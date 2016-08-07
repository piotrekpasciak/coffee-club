class UserMailer < ApplicationMailer
  default from: "coffee_club@test.com"

  def event_new_notification(event)
    @event = event
    @users_emails = User.newsletter_member.pluck(:email).reject { |email| email == @event.owner.to_s }
    mail(to: @users_emails,
         subject: event.owner.to_s + " has created new coffee event!") unless @users_emails.empty?
  end

  def event_close_notification(event, user)
    @event = event
    @users_emails = @event.participants_emails
    @user = user
    mail(to: @user,
         subject: "Event you have participated in reached required number of participants!")
  end

  def event_expire_notification(event)
    @event = event
    @users_emails = @event.participants_emails
    mail(to: @users_emails,
         subject: "Event you have participated in has expired!")
  end

  def event_extend_notification(event)
    @event = event
    @users_emails = @event.participants_emails
    mail(to: @users_emails,
         subject: "Event you have participated in has been extended!")
  end
end
