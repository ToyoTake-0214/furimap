class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  # :validatable は外す

  enum :role, { organizer: 0, general: 1 }

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, scope: :role, allow_blank: true, case_sensitive: true, if: :devise_will_save_change_to_email?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :devise_will_save_change_to_email?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, minimum: Devise.password_length.min, maximum: Devise.password_length.max, allow_blank: true

  has_many :events
  has_many :favorites, dependent: :destroy
  has_many :favorite_events, through: :favorites, source: :event

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end
end
