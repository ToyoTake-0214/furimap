require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "有効な属性のvalidであること" do
    event = events(:one)
    assert event.valid?, event.errors.full_messages.join(", ")
   end
end
