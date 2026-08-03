class EventSchedule < ApplicationRecord
  validates :event_date, presence: true

  belong_to :event
end
