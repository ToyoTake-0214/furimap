require 'rails_helper'

RSpec.describe "UserRegistrations", type: :system do
  describe "主催者ユーザー" do
    context "正しいメールアドレスとパスワードの場合" do
      it "新規登録できること" do
        visit new_user_registration_path
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "アカウント登録"
        expect(page).to have_current_path events_path
        expect(User.find_by(email: "test@example.com").role).to eq("organizer")
      end
    end

    context "パスワード（確認用）が一致しない場合" do
      it "新規登録できず、エラーメッセージが表示されること" do
        visit new_user_registration_path
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "different"
        expect { click_button "アカウント登録" }.not_to change(User, :count)
        expect(page).to have_current_path user_registration_path
        expect(page).to have_content("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end

  describe "一般ユーザー" do
    context "正しいメールアドレスとパスワードの場合" do
      it "新規登録できること" do
        visit new_general_registration_path
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "アカウント登録"
        expect(page).to have_current_path root_path
        expect(User.find_by(email: "test@example.com").role).to eq("general")
      end
    end

    context "パスワード（確認用）が一致しない場合" do
      it "新規登録できず、エラーメッセージが表示されること" do
        visit new_general_registration_path
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "different"
        expect { click_button "アカウント登録" }.not_to change(User, :count)
        expect(page).to have_current_path general_registration_path
        expect(page).to have_content("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
