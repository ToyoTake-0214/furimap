require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "有効な属性のvalidであること" do
    event = events(:one)
    assert event.valid?, event.errors.full_messages.join(", ")
   end

  test "nameが空の場合はinvalidであること" do
    event = events(:one)
    event.name = ""
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "addressが空の場合はinvalidであること" do
    event = events(:one)
    event.address = ""
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_timeが空の場合はinvalidであること" do
    event = events(:one)
    event.event_time = ""
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end
end
