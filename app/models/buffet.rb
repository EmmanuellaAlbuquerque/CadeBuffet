class Buffet < ApplicationRecord
  belongs_to :buffet_owner

  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
end
