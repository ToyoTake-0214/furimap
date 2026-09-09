require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "emailが空の場合はinvalidであること" do
    user = users(:one)
    user.email = ""
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "emailが不正な形式の場合はinvalidであること" do
    user = users(:one)
    user.email = "invalid-email"
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "新規作成時にpasswordが空の場合はinvalidであること" do
    user = User.new(email: "new@example.com", password: "", role: :organizer)
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "新規作成時にpasswordとpassword_confirmationが一致しない場合はinvalidであること" do
    user = User.new(email: "new@example.com", password: "password", password_confirmation: "password1")
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "passwordが5文字の場合はinvalidであること" do
    user = User.new(email: "new@example.com", password: "a" * 5, password_confirmation: "a" * 5, role: :organizer)
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "passwordが6文字の場合はvalidであること" do
    user = User.new(email: "new@example.com", password: "a" * 6, password_confirmation: "a" * 6, role: :organizer)
    assert user.valid?, user.errors.full_messages.join(", ")
  end

  test "passwordが128文字の場合はvalidであること" do
    user = User.new(email: "new@example.com", password: "a" * 128, password_confirmation: "a" * 128, role: :organizer)
    assert user.valid?, user.errors.full_messages.join(", ")
  end

  test "passwordが129文字の場合はinvalidであること" do
    user = User.new(email: "new@example.com", password: "a" * 129, password_confirmation: "a" * 129, role: :organizer)
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end

  test "同じroleで既存のemailと重複する場合はinvalidであること" do
    user = User.new(email: users(:one).email, password: "password", password_confirmation: "password", role: :organizer)
    assert_not user.valid?, user.errors.full_messages.join(", ")
  end
end
