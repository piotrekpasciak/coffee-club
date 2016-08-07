class StatisticsUtility
  def initialize(user = nil)
    @user = user
  end

  def user_coffee_count
    @user_coffee_count ||= user.try(:coffee_counter)
  end

  def app_coffees
    @app_coffes ||= User.sum(:coffee_counter)
  end

  def to_json
    {
        user_coffee_count: user_coffee_count,
        app_coffees: app_coffees
    }
  end

  private

  attr_reader :user
end
