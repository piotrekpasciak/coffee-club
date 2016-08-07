class CommentsController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :authenticate_user!

  def create
    event = CommentEventService.new(@event, current_user, comment_params[:text]).call
    render json: event, status: :ok
  rescue CommentEventService::Error => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
