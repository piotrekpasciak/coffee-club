class UsersController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show_current_user
    render json: current_user, status: :ok
  end

  def update_subscription
    if current_user.newsletter || current_user.temporary_newsletter_status
      current_user.newsletter = false
      current_user.temporary_newsletter = false
      current_user.temporary_newsletter_status = false
    else
      current_user.newsletter = true
    end

    render json: current_user, status: :ok if current_user.save
  end

  def update_temporary_subscription
    current_user.temporary_newsletter_status = true
    current_user.temporary_newsletter = true

    redirect_to root_url, notice: "You have subscribed to newsletter temporarly!" if current_user.save
  end
end
