require "test_helper"

class EventScheduleTest < ActiveSupport::TestCase
test "event_dateが空の場合はinvalidであること" do
  event_schedule = event_schedules(:one)
  event_schedule.event_date = nil
  assert_not event_schedule.valid?, event_schedule.errors.full_messages.join(", ")
end

test "event_dateに同じ値が登録されたらinvalidであること" do
  event_schedule = EventSchedule.new(event: event_schedules(:one).event, event_date: "2026-08-10")
  assert_not event_schedule.valid?, event_schedule.errors.full_messages.join(", ")
end
end
