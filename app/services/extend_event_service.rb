class ExtendEventService
  class Error < StandardError; end

  attr_reader :event, :current_user

  def initialize(event, user)
    @event = event
    @current_user = user
  end

  def call
    raise Error.new("You can extend only expired events!") unless event.expired?

    raise Error.new("Only owner can extend expired event!") unless current_user.owner_of?(event)

    event.status = :open
    event.created_at = Time.now
    raise Error.new("Event is invalid!") unless event.save

    UserMailer.event_extend_notification(event).deliver_later

    event
  end
end
