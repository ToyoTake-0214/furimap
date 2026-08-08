class MainPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :top

  def top
    @events = Event.all
    @prefectures ||= YAML.load_file(Rails.root.join("config/prefectures.yml"))
  end
end
