namespace :event_schedules do
  desc "開催日を過ぎたEventScheduleを削除する"
  task delete_past: :environment do
    EventSchedule.past.delete_all
  end
end
