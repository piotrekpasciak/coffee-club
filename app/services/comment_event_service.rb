class CommentEventService
  class Error < StandardError; end

  attr_reader :event, :event_id, :current_user, :text

  def initialize(event, user, text)
    @event = event
    @current_user = user
    @text = text
  end

  def call
    raise Error.new("Only member of event can comment it!") unless current_user.member_of?(event)
    raise Error.new("You can only comment done events!") unless event.done?

    comment = Comment.create(user_id: current_user.id, event_id: event.id, text: text)

    raise Error.new("Textarea cannot be empty!") unless comment.valid?

    true
  end
end
