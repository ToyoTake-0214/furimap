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
    describe "description" do
      context "空の場合" do
        it "有効であること" do
          event = build(:event, description: "")
          expect(event).to be_valid
        end
      end

      describe "文字数" do
        context "2000文字の場合" do
          it "有効であること" do
            event = build(:event, description: "a" * 2000)
            expect(event).to be_valid
          end
        end

        context "2001文字の場合" do
          it "無効であること" do
            event = build(:event, description: "a" * 2001)
            event.valid?
            expect(event.errors[:description]).to be_present
          end
        end
      end
    end

    describe "store_count" do
      context "空の場合" do
        it "有効であること" do
          event = build(:event, store_count: nil)
          expect(event).to be_valid
        end
      end

      context "0の場合" do
        it "無効であること" do
          event = build(:event, store_count: 0)
          event.valid?
          expect(event.errors[:store_count]).to be_present
        end
      end

      context "1の場合" do
        it "有効であること" do
          event = build(:event, store_count: 1)
          expect(event).to be_valid
        end
      end

      context "整数でない場合" do
        it "無効であること" do
          event = build(:event, store_count: 1.5)
          event.valid?
          expect(event.errors[:store_count]).to be_present
        end
      end
    end

    describe "event_url" do
      context "空の場合" do
        it "有効であること" do
          event = build(:event, event_url: "")
          expect(event).to be_valid
        end
      end

      context "正しい形式の場合" do
        it "有効であること" do
          event = build(:event, event_url: "https://example.com")
          expect(event).to be_valid
        end
      end

      context "不正な形式の場合" do
        it "無効であること" do
          event = build(:event, event_url: "hts://example.com")
          event.valid?
          expect(event.errors[:event_url]).to be_present
        end
      end

      describe "文字数" do
        context "500文字の場合" do
          it "有効であること" do
            event = build(:event, event_url: "https://example.com/" + "a" * 480)
            expect(event).to be_valid
          end
        end

        context "501文字の場合" do
          it "無効であること" do
            event = build(:event, event_url: "https://example.com/" + "a" * 481)
            event.valid?
            expect(event.errors[:event_url]).to be_present
          end
        end
      end
    end
  end

  describe "ジオコーディング" do
    context "新しく作成した場合" do
      it "住所から緯度経度が設定されること" do
        event = create(:event)
        expect(event.latitude).to eq(35.681236)
        expect(event.longitude).to eq(139.767125)
      end
    end

    context "住所を変更して更新した場合" do
      after do
        Geocoder::Lookup::Test.delete_stub("大阪駅")
      end

      it "新しい住所の緯度経度に更新されること" do
        event = create(:event)
        Geocoder::Lookup::Test.add_stub("大阪駅", [ { "coordinates" => [ 34.702485, 135.495951 ] } ])

        event.update(address: "大阪駅")

        expect(event.latitude).to eq(34.702485)
        expect(event.longitude).to eq(135.495951)
      end
    end

    context "住所以外を変更して更新した場合" do
      it "緯度経度を再取得しないこと" do
        event = create(:event)
        expect(event).not_to receive(:geocode)

        event.update(name: "大阪駅フリーマーケット")
      end
    end
  end
end
