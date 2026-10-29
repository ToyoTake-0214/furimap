require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "バリデーション" do
    it "user、eventがあれば有効であること" do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    describe "user" do
      context "存在しない場合" do
        it "無効であること" do
          favorite = build(:favorite, user: nil)
          favorite.valid?
          expect(favorite.errors[:user]).to be_present
        end
      end
    end

    describe "event" do
      context "存在しない場合" do
        it "無効であること" do
          favorite = build(:favorite, event: nil)
          favorite.valid?
          expect(favorite.errors[:event]).to be_present
        end
      end
    end
  end
  describe "DBの制約" do
    it "同じuserが同じeventを2回お気に入りすると、例外が発生する" do
      favorite = create(:favorite)
      expect { create(:favorite, user: favorite.user, event: favorite.event) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "違うユーザーなら同じeventをお気に入りにすることができる" do
      favorite = create(:favorite)
      expect { create(:favorite, event: favorite.event) }.not_to raise_error
    end
  end
end
