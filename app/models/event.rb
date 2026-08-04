class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 100 }


  belongs_to :user
  has_many :event_schedules, dependent: :destroy
  accepts_nested_attributes_for :event_schedules, reject_if: :all_blank

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
