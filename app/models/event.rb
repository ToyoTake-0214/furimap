class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 100 }


  belongs_to :user
  has_many :event_schedules, -> { order(:event_date) }, dependent: :destroy
  accepts_nested_attributes_for :event_schedules, reject_if: :all_blank, allow_destroy: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  mount_uploader :event_image, EventImageUploader
end
