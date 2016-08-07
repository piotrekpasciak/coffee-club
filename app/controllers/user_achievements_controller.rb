class UserAchievementsController < ActionController::Base
  before_action :set_user_achievements, only: [:update_all]
  before_action :authenticate_user!

  respond_to :json

  def user_achievements
    @user_achievements = current_user.achievements
    render json: @user_achievements
  end

  def show_user_achievements
    AchievementService.new(current_user).call
    @user_achievements = Achievement.not_shown(current_user)
    render json: @user_achievements
  end

  def update_all
    @user_achievements.update_all(shown: true)
    head :ok
  end

  private

  def set_user_achievements
    @user_achievements = UserAchievement.where(params[:user_achievements])
  end
end
