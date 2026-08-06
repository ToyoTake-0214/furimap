class MainPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :top

  def top
    @events = Event.all
  end
end
