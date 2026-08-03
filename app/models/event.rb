class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }

  belongs_to :user
  has_many :event_schedules, dependent: :destroy
end
