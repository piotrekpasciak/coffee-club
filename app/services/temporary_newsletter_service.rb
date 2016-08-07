class TemporaryNewsletterService
  class Error < StandardError; end

  attr_reader :current_user, :action

  def initialize(user, action)
    @current_user = user
    @action = action
  end

  def call
    return false unless current_user.temporary_newsletter_status

    if action == :join
      current_user.update(temporary_newsletter: false)
    elsif action == :leave
      current_user.update(temporary_newsletter: true)
    elsif action == :close
      current_user.update(temporary_newsletter: false, temporary_newsletter_status: false)
    end

    true
  end
end
