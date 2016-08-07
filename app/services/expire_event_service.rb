class ExpireEventService
  class Error < StandardError; end

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def call
    raise Error.new("You can expire only open events!") unless event.open? || event.expired?
    raise Error.new("You can expire only events with no remaining time!") unless event.expirable?

    event.status = :expired

    raise Error.new("Event is invalid!") unless event.save

    UserMailer.event_expire_notification(event).deliver_later

    event
  end
end
