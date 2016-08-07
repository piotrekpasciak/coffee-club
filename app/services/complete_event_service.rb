class CompleteEventService
  class Error < StandardError; end

  attr_reader :event, :current_user

  def initialize(event, user)
    @event = event
    @current_user = user
  end

  def call
    raise Error.new("You can't complete event that you're not member of!") unless current_user.member_of?(event)
    raise Error.new("Only owner can complete event!") unless current_user.owner_of?(event)
    raise Error.new("You can complete only open and expired events!") unless event.open? || event.expired?
    raise Error.new("You need at least one more participant to complete event!") unless event.completable?
    event.status = :closed

    raise Error.new("Event is invalid!") unless event.save

    event.users.each do |user|
      TemporaryNewsletterService.new(user, :close).call
      UserMailer.event_close_notification(event, user).deliver_later
    end

    event
  end
end
