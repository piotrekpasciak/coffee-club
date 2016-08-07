class PageController < ApplicationController
  layout "frontend"

  before_action :authenticate_user!

  respond_to :html, :json

  def home
    events = Event.open_status.non_expirable.includes(:owner)

    respond_with(events, root: false)
  end

  def my_events
    events = current_user.events.all_and_open_non_expirable.includes(:owner)
    respond_with(events, root: false)
  end

  def ranking
    addicts = User.where("users.coffee_counter > 0").order("users.coffee_counter DESC, users.email").limit(10)
    managers = User.joins("LEFT JOIN events ON users.id = events.user_id").select(%q{ users.id as id, users.email, COUNT(DISTINCT events.id) AS count })
                   .where("events.status = 'done'").limit(10).group("events.user_id, users.id").order("users.count DESC, users.email")

    respond_with({ addicts: addicts, managers: managers }, status: :ok)
  end

  def coffee_counters
    stats = StatisticsUtility.new(current_user)
    render json: { stats: stats.to_json }, status: :ok
  end
end
