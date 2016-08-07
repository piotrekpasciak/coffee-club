class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]
  before_action :new_set_event, only: [:confirm, :complete, :expire, :extend, :leave]
  before_action :set_time_length, only: [:extend]
  before_action :authenticate_user!

  respond_to :html
  layout "frontend"

  def show
    @participations = @event.participations.includes(:user)
    respond_to do |format|
      format.html { respond_with(@event, @participations) }
      format.json { render json: @event, serializer: EventSerializer }
    end
  end

  def create
    event = current_user.events.create(event_params.merge(status: :open, owner: current_user))
    if event.valid?
      UserMailer.event_new_notification(event).deliver_later
      render json: event, status: :ok
    else
      render json: { message: event.errors.messages }, status: :unprocessable_entity
    end
  end

  def complete
    event = CompleteEventService.new(@event, current_user).call
    render json: event, status: :ok
  rescue CompleteEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def confirm
    response = ConfirmEventService.new(@event, current_user).call
    render json: { event: EventSerializer.new(event_hash_to_object(response[:event]), scope: current_user).as_json,
                   achievements: achievements_hash_to_objects(response[:achievements]) }, status: :ok
  rescue ConfirmEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def leave
    event = LeaveEventService.new(@event, current_user).call
    render json: event, status: :ok
  rescue LeaveEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def expire
    event = ExpireEventService.new(@event).call
    render json: event, status: :ok
  rescue ExpireEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def extend
    event = ExtendEventService.new(@event, current_user).call
    render json: event, status: :ok
  rescue ExtendEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def new_set_event
    @event = Event.find(params[:event_id])
  end

  def set_time_length
    @event.time_length = params.require(:time_length)
  end

  def event_params
    params.require(:event).permit(:description, :time_length, :people_amount, :status)
  end

  def event_hash_to_object(hash)
    Event.new(id: hash.id, description: hash.description, time_length: hash.time_length, people_amount: hash.people_amount,
              status: hash.status, user_id: hash.user_id, created_at: hash.created_at, updated_at: hash.updated_at)
  end

  def achievements_hash_to_objects(hash)
    serialized_achievements = []
    hash.each do |element|
      serialized_achievements << AchievementSerializer.new(Achievement.new(id: element.id, name: element.name, symbol: element.symbol,
                                                                           text: element.text, image: element.image, created_at: element.created_at,
                                                                           updated_at: element.updated_at)).as_json
    end
    serialized_achievements
  end
end
