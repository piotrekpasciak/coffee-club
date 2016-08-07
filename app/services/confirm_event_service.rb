class ConfirmEventService
  class Error < StandardError; end

  attr_reader :event, :current_user

  def initialize(event, user)
    @event = event
    @current_user = user
  end

  def call
    raise Error.new("You can't confirm event that you're not member of!") unless current_user.member_of?(event)
    raise Error.new("You can confirm only closed event!") unless event.closed?

    event.status = :done
    event.users.update_all("coffee_counter = coffee_counter + 1, updated_at = current_timestamp")
    raise Error.new("Event is invalid!") unless event.save

    achievements = AchievementService.new(current_user).call

    { event: event, achievements: achievements }
  end
end
