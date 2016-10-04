class Bid < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :price, presence: true, numericality: {greater_than: 1}
end
