class JoinEventService
  class Error < StandardError; end

  attr_reader :event, :event_id, :current_user

  def initialize(event, user)
    @event = event
    @current_user = user
  end

  def call
    raise Error.new("You're already member of this event!") if Participation.where(user_id: current_user.id, event_id: event.id).any?
    raise Error.new("Event is already closed!") unless event.open?
    raise Error.new("Event is full!") if event.full?

    Participation.create(user_id: current_user.id, event_id: event.id)

    TemporaryNewsletterService.new(current_user, :join).call

    if event.full?
      event.update(status: :closed)
      event.users.each do |user|
        UserMailer.event_close_notification(event, user).deliver_later
      end
    end

    event
  end
end
