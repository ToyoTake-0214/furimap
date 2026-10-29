require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "email、password、roleがあれば有効であること" do
      user = build(:user)
      expect(user).to be_valid
    end

    describe "email" do
      context "空の場合" do
        it "無効であること" do
          user = build(:user, email: "")
          user.valid?
          expect(user.errors[:email]).to be_present
        end
      end

      context "不正な形式の場合" do
        it "無効であること" do
          user = build(:user, email: "user@")
          user.valid?
          expect(user.errors[:email]).to be_present
        end
      end

      context "同じroleで重複する場合" do
        it "無効であること" do
          create(:user, email: "user@example.com")
          user = build(:user, email: "user@example.com", role: "organizer")
          user.valid?
          expect(user.errors[:email]).to be_present
        end
      end

      context "違うroleで重複する場合" do
        it "有効であること" do
          create(:user, email: "user@example.com")
          user = build(:user, email: "user@example.com", role: "general")
          expect(user).to be_valid
        end
      end
    end

    describe "password" do
      context "空の場合" do
        it "無効であること" do
          user = build(:user, password: "")
          user.valid?
          expect(user.errors[:password]).to be_present
        end
      end

      context "確認用と一致しない場合" do
        it "無効であること" do
          user = build(:user, password: "password", password_confirmation: "Password")
          user.valid?
          expect(user.errors[:password_confirmation]).to be_present
        end
      end

      describe "文字数" do
        context "5文字の場合" do
          it "無効であること" do
            user = build(:user, password: "a" * 5)
            user.valid?
            expect(user.errors[:password]).to be_present
          end
        end

        context "6文字の場合" do
          it "有効であること" do
            user = build(:user, password: "a" * 6)
            expect(user).to be_valid
          end
        end

        context "128文字の場合" do
          it "有効であること" do
            user = build(:user, password: "a" * 128)
            expect(user).to be_valid
          end
        end

        context "129文字の場合" do
          it "無効であること" do
            user = build(:user, password: "a" * 129)
            user.valid?
            expect(user.errors[:password]).to be_present
          end
        end
      end
    end

    describe "role" do
      it "organizerが0、generalが1に対応していること" do
        expect(User.roles).to eq({ "organizer" => 0, "general" => 1 })
      end
    end
  end

  describe "アソシエーション" do
    it "お気に入りしたイベントを取得できること" do
      favorite = create(:favorite)
      expect(favorite.user.favorite_events).to include(favorite.event)
    end

    context "ユーザーを削除した場合" do
      it "お気に入りも削除されること" do
        favorite = create(:favorite)
        expect { favorite.user.destroy }.to change(Favorite, :count).by(-1)
      end
    end
  end
end
