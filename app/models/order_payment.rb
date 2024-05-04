class OrderPayment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  validates :validity_date, :standard_price, presence: true
  validates :extra_tax, :discount, numericality: { greater_than_or_equal_to: 0 }
  validates :order_id, uniqueness: true
end
