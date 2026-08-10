class EventSchedule < ApplicationRecord
  validates :event_date, presence: true

  belongs_to :event

  scope :past, -> { where("event_date < ?", Date.current) }
end
