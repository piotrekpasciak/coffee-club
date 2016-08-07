class LeaveEventService
  class Error < StandardError; end

  attr_reader :event, :current_user

  def initialize(event, user)
    @event = event
    @current_user = user
  end

  def call
    participation = event.participations.where(user: current_user).take
    raise Error.new("Owner can't leave his own events!") if current_user.owner_of?(event)
    raise Error.new("You can only leave open events!") unless event.open?
    raise Error.new("You are not a member of this event!") if participation.nil?

    participation.destroy

    TemporaryNewsletterService.new(current_user, :leave).call

    event
  end
end
