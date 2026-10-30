require 'rails_helper'

RSpec.describe "Events", type: :system do
  describe "主催者のイベント登録" do
    context "必須項目と開催日を入力した場合" do
      it "イベント登録ができ、登録したイベント名がイベント一覧に表示されること" do
        user = create(:user)
        sign_in user
        visit new_event_path
        fill_in "イベント名", with: "東京フリマ"
        fill_in "住所", with: "東京駅"
        fill_in "開催時間", with: "10:00〜15:00"
        fill_in "event_event_schedules_attributes_0_event_date", with: Date.tomorrow
        expect { click_button "登録する" }.to change(Event, :count).by(1)
        expect(page).to have_current_path events_path
        expect(page).to have_content("東京フリマ")
      end
    end

    context "イベント名（必須項目）が空の場合" do
      it "イベント登録ができず、エラーメッセージが表示されること" do
        user = create(:user)
        sign_in user
        visit new_event_path
        fill_in "イベント名", with: ""
        fill_in "住所", with: "東京駅"
        fill_in "開催時間", with: "10:00〜15:00"
        fill_in "event_event_schedules_attributes_0_event_date", with: Date.tomorrow
        expect { click_button "登録する" }.not_to change(Event, :count)
        expect(page).to have_current_path events_path
        expect(page).to have_content("イベント名を入力してください")
      end
    end
  end
end
