class FavoritesController < ApplicationController
  before_action :require_general!
  before_action :set_favorite, only: [ :destroy ]

  def index
    @favorites = current_user.favorites.includes(event: :event_schedules).order(created_at: :desc)
  end

  def create
    event = Event.find(params[:event_id])
    @favorite = current_user.favorites.create(event: event)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @favorite.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: favorites_path }
    end
  end

  private

  def require_general!
    redirect_to root_path, alert: "一般ユーザー登録が必要です" unless current_user.general?
  end

  def set_favorite
    @favorite = current_user.favorites.find(params[:id])
  end
end
