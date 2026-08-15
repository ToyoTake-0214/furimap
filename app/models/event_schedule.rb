class EventSchedule < ApplicationRecord
  validates :event_date, presence: true, uniqueness: { scope: :event_id }

  belongs_to :event

  scope :past, -> { where("event_date < ?", Date.current) }
end
