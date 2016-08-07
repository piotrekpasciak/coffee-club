class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :destroy]
  before_action :set_event, only: [:index, :create]
  before_action :authenticate_user!

  layout "frontend"

  def create
    event = JoinEventService.new(@event, current_user).call
    render json: event, status: :ok
  rescue JoinEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def destroy
    @participation.destroy
    redirect_to root_url
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
