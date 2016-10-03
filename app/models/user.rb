class User < ApplicationRecord
  has_secure_password

  has_many :item, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

end
