class MainPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :top

  def top
    @events = Event.where.not(latitude: nil, longitude: nil).includes(:event_schedules)
    @prefectures ||= YAML.load_file(Rails.root.join("config/prefectures.yml"))

    @locations_for_map = build_locations_for_map(@events)
  end

  private

  def build_locations_for_map(events)
    grouped_events = events.group_by do |event|
      [ event.latitude, event.longitude ]
    end

    grouped_events.map do |(latitude, longitude), grouped_events|
      schedules = grouped_events.flat_map do |event|
        event.event_schedules.map do |schedule|
          build_schedule_data(schedule, event)
        end
      end

      { latitude: latitude, longitude: longitude, schedules: schedules.sort_by { |schedule| schedule[:event_date] } }
      end
    end

    def build_schedule_data(schedule, event)
        {
      id: schedule.id,
      event_date: schedule.event_date,
      event: {
        id: event.id,
        name: event.name,
        description: event.description,
        address: event.address,
        image_url: event.event_image_url
      }
    }
  end
end
