class AchievementService
  class Error < StandardError; end

  attr_reader :current_user, :achievements

  def initialize(user)
    @current_user = user
    @achievements = []
  end

  def call
    set_achievement(Achievement.find_by(symbol: "first_coffee")) if current_user.coffee_counter >= 1

    set_achievement(Achievement.find_by(symbol: "10_coffees")) if current_user.coffee_counter >= 10

    set_achievement(Achievement.find_by(symbol: "100_coffees")) if current_user.coffee_counter >= 100

    set_achievement(Achievement.find_by(symbol: "first_event")) if current_user.event_counter >= 1

    set_achievement(Achievement.find_by(symbol: "10_events")) if current_user.event_counter >= 10

    set_achievement(Achievement.find_by(symbol: "100_events")) if current_user.event_counter >= 100

    set_achievement(Achievement.find_by(symbol: "highscores")) if current_user.top?(10)

    set_achievement(Achievement.find_by(symbol: "third_place")) if current_user.top?(3)

    set_achievement(Achievement.find_by(symbol: "second_place")) if current_user.top?(2)

    set_achievement(Achievement.find_by(symbol: "coffee_leader")) if current_user.top?(1)

    set_achievement(Achievement.find_by(symbol: "no_coffee")) if current_user.days_without_coffee?(7)

    set_achievement(Achievement.find_by(symbol: "golden_vulture")) if current_user.coffee_counter >= 10 && current_user.event_counter == 0

    achievements
  end

  private

  def set_achievement(achievement)
    new_achievement = UserAchievement.new(user: current_user, achievement: achievement).save
    achievements << achievement if new_achievement
  end
end
