namespace :cron do
  desc "Expires event with no remaining time"

  task expire_old_open_events: :environment do
    @events = Event.open_status.expirable.map { |event| ExpireEventService.new(event).call }
  end
end
