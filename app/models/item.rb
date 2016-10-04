class Item < ApplicationRecord
  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :users, through: :bids

  after_initialize :set_reserved_default
  after_initialize :set_price_default

  validates :name, presence: true
  validates :description, presence: true
  validates :current_price, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}
  validates :aasm_state, presence: true
  validates :end_date, presence: true

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :canceled
    state :reserve_met
    state :reserve_not_met
    state :won

    event :publish do
      transitions from: :draft, to: :published
    end

    event :reserve_unmet do
      transitions from: :published, to: :reserve_not_met
    end

    event :reserve_met do
      transitions from: [:reserve_not_met, :published], to: :reserve_met
    end

    event :cancel do
      transitions from: [:published, :reserve_met, :reserve_not_met], to: :reserve_met
    end

    event :won do
      transitions from: :reserve_met, to: :won
    end
  end

  protected

  def set_reserved_default
    self.reserve_price ||= 1
  end

  def set_price_default
    self.current_price ||= 0
  end

end
