class EventSchedule < ApplicationRecord
  validates :event_date, presence: true

  belongs_to :event
end
