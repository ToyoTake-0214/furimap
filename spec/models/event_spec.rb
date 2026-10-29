require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "バリデーション" do
    it "name、address、event_time、userがあれば有効であること" do
      event = build(:event)
      expect(event).to be_valid
    end

    describe "name" do
      context "空の場合" do
        it "無効であること" do
          event = build(:event, name: "")
          event.valid?
          expect(event.errors[:name]).to be_present
        end
      end

      describe "文字数" do
        context "50文字の場合" do
          it "有効であること" do
            event = build(:event, name: "a" * 50)
            expect(event).to be_valid
          end
        end

        context "51文字の場合" do
          it "無効であること" do
            event = build(:event, name: "a" * 51)
            event.valid?
            expect(event.errors[:name]).to be_present
          end
        end
      end
    end

    describe "address" do
      context "空の場合" do
        it "無効であること" do
          event = build(:event, address: "")
          event.valid?
          expect(event.errors[:address]).to be_present
        end
      end

      describe "文字数" do
        context "100文字の場合" do
          it "有効であること" do
            event = build(:event, address: "a" * 100)
            expect(event).to be_valid
          end
        end

        context "101文字の場合" do
          it "無効であること" do
            event = build(:event, address: "a" * 101)
            event.valid?
            expect(event.errors[:address]).to be_present
          end
        end
      end
    end

    describe "event_time" do
      context "空の場合" do
        it "無効であること" do
          event = build(:event, event_time: "")
          event.valid?
          expect(event.errors[:event_time]).to be_present
        end
      end

      describe "文字数" do
        context "50文字の場合" do
          it "有効であること" do
            event = build(:event, event_time: "a" * 50)
            expect(event).to be_valid
          end
        end

        context "51文字の場合" do
          it "無効であること" do
            event = build(:event, event_time: "a" * 51)
            event.valid?
            expect(event.errors[:event_time]).to be_present
          end
        end
      end
    end

    describe "user" do
      context "存在しない場合" do
        it "無効であること" do
          event = build(:event, user: nil)
          event.valid?
          expect(event.errors[:user]).to be_present
        end
      end
    end
  end
end
