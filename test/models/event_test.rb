require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "有効な属性のvalidであること" do
    event = events(:one)
    assert event.valid?, event.errors.full_messages.join(", ")
   end

  # Event必須項目(presence)の空テスト
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

  # 文字数バリデーション（境界値）のテスト
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

  # store_count（数値バリデーション）のテスト
  test "store_countがnilの場合はvalidであること" do
    event = events(:one)
    event.store_count = nil
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "store_countが正の整数の場合はvalidであること" do
    event = events(:one)
    event.store_count = 1
    assert event.valid?, event.errors.full_messages.join(", ")

    event.store_count = 5
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "store_countが0の場合はinvalidであること" do
    event = events(:one)
    event.store_count = 0
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "store_countが負の値の場合はinvalidであること" do
    event = events(:one)
    event.store_count = -1
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "store_countが正の整数でない場合はinvalidであること" do
    event = events(:one)
    event.store_count = 1.5
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  # event_url（形式バリデーション）のテスト
  test "event_urlがnilの場合はvalidであること" do
    event = events(:one)
    event.event_url = nil
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_urlが正しいURLの場合はvalidであること" do
    event = events(:one)
    event.event_url = "https://example.com"
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_urlが不正な形式のURLの場合はinvalidであること" do
    event = events(:one)
    event.event_url = "hts://example.com"
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_urlが501文字の場合はinvalidであること" do
    event = events(:one)
    event.event_url = "https://example.com/" + "a" * 481   # 20文字 + 481文字 = 501文字
    assert_not event.valid?, event.errors.full_messages.join(", ")
  end

  test "event_urlが500文字の場合はvalidであること" do
    event = events(:one)
    event.event_url = "https://example.com/" + "a" * 480   # 20文字 + 480文字 = 500文字
    assert event.valid?, event.errors.full_messages.join(", ")
  end

  # アソシエーションが正しく機能するかテスト
  test "紐づくuserを取得できること" do
    event = events(:one)
    assert_equal event.user, users(:one)
  end

  test "紐づくevent_schedulesを取得できること" do
  event = events(:one)
  assert_includes event.event_schedules, event_schedules(:one)
  end
end
