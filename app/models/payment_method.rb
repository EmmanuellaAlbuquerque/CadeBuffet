class PaymentMethod < ApplicationRecord
  validates :name, uniqueness: true

  has_many :buffet_payment_methods
  has_many :buffet, through: :buffet_payment_methods
end
