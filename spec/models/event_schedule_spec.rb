require 'rails_helper'

RSpec.describe EventSchedule, type: :model do
  describe "バリデーション" do
    it "event、event_dateがあれば有効であること" do
      event_schedule = build(:event_schedule)
      expect(event_schedule).to be_valid
    end

    describe "event_date" do
      context "空の場合" do
        it "無効であること" do
          event_schedule = build(:event_schedule, event_date: nil)
          event_schedule.valid?
          expect(event_schedule.errors[:event_date]).to be_present
        end
      end

      context "同じEventで同じ日付が登録されている場合" do
        it "無効であること" do
          existing_schedule = create(:event_schedule)
          event_schedule = build(:event_schedule, event: existing_schedule.event, event_date: existing_schedule.event_date)
          event_schedule.valid?
          expect(event_schedule.errors[:event_date]).to be_present
        end
      end

      context "違うEventで同じ日付が登録されている場合" do
        it "有効であること" do
          existing_schedule = create(:event_schedule)
          event_schedule = build(:event_schedule, event_date: existing_schedule.event_date)
          expect(event_schedule).to be_valid
        end
      end
    end

    describe "event" do
      context "存在しない場合" do
        it "無効であること" do
          event_schedule = build(:event_schedule, event: nil)
          event_schedule.valid?
          expect(event_schedule.errors[:event]).to be_present
        end
      end
    end
  end

  describe ".past" do
    it "昨日の日程は含まれること" do
      yesterday_schedule = create(:event_schedule, event_date: Date.yesterday)
      expect(EventSchedule.past).to include(yesterday_schedule)
    end

    it "今日の日程は含まれないこと" do
      today_schedule = create(:event_schedule, event_date: Date.current)
      expect(EventSchedule.past).not_to include(today_schedule)
    end
  end
end
