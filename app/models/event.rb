class Event < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 2000 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :event_time, presence: true, length: { maximum: 50 }
  validates :store_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :event_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, length: { maximum: 500 }, allow_blank: true


  belongs_to :user
  has_many :event_schedules, -> { order(:event_date) }, dependent: :destroy
  accepts_nested_attributes_for :event_schedules, reject_if: :all_blank, allow_destroy: true

  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  mount_uploader :event_image, EventImageUploader
end
