require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "DELETE /events/:id" do
    context "自分のイベントの場合" do
      it "削除され、一覧にリダイレクトされること" do
        user = create(:user)
        event = create(:event, user: user)
        sign_in user
        expect { delete event_path(event) }.to change(Event, :count).by(-1)
        expect(response).to redirect_to events_path
      end
    end

    context "他の主催者のイベントの場合" do
      it "削除されず、404が返されること" do
        user = create(:user)
        other_event = create(:event)
        sign_in user
        expect { delete event_path(other_event) }.not_to change(Event, :count)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
