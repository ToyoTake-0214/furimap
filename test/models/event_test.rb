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

  test "nameが51文字以上の場合はinvalidであること" do
    event = events(:one)
    event.name = "a" * 51
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "nameが50文字の場合はvalidであること" do
    event = events(:one)
    event.name = "a" * 50
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "descriptionが2001文字以上の場合はinvalidであること" do
    event = events(:one)
    event.description = "a" * 2001
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "descriptionが2000文字の場合はvalidであること" do
    event = events(:one)
    event.description = "a" * 2000
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "addressが101文字以上の場合はinvalidであること" do
    event = events(:one)
    event.address = "a" * 101
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "addressが100文字の場合はvalidであること" do
    event = events(:one)
    event.address = "a" * 100
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_timeが51文字以上の場合はinvalidであること" do
    event = events(:one)
    event.event_time = "a" * 51
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_timeが50文字の場合はvalidであること" do
    event = events(:one)
    event.event_time = "a" * 50
    assert event.valid?, event.errors.full_messages.join(", ")
  end
end
