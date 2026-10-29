require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  context "正しいメールアドレスとパスワードの場合" do
    it "ログインできること" do
      user = create(:user)
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(page).to have_current_path events_path
    end
  end

  context "パスワードが間違っている場合" do
    it "ログインできず、エラーメッセージが表示されること" do
      user = create(:user)
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "different"
      click_button "ログイン"
      expect(page).to have_current_path new_user_session_path
      expect(page).to have_content("メールアドレスまたはパスワードが違います。")
    end
  end
end
