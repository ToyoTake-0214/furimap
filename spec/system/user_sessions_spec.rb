require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  describe "主催者ユーザー" do
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

    context "ロールが間違っている場合" do
      it "ログインできず、エラーメッセージが表示されること" do
        general = create(:user, role: "general")
        visit new_user_session_path
        fill_in "メールアドレス", with: general.email
        fill_in "パスワード", with: general.password
        click_button "ログイン"
        expect(page).to have_current_path new_user_session_path
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end
  end

  describe "一般ユーザー" do
    context "正しいメールアドレスとパスワードの場合" do
      it "ログインできること" do
        user = create(:user, role: "general")
        visit new_general_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(page).to have_current_path root_path
      end
    end

    context "パスワードが間違っている場合" do
      it "ログインできず、エラーメッセージが表示されること" do
        user = create(:user, role: "general")
        visit new_general_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "different"
        click_button "ログイン"
        expect(page).to have_current_path new_general_session_path
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end

    context "ロールが間違っている場合" do
      it "ログインできず、エラーメッセージが表示されること" do
        organizer = create(:user, role: "organizer")
        visit new_general_session_path
        fill_in "メールアドレス", with: organizer.email
        fill_in "パスワード", with: organizer.password
        click_button "ログイン"
        expect(page).to have_current_path new_general_session_path
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end
  end
end
