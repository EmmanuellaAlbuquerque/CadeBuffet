class OrderPayment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  validates :validity_date, :standard_price, presence: true
  validates :extra_tax, :discount, numericality: { greater_than_or_equal_to: 0 }
  validates :order_id, uniqueness: true

  validate :validity_date_is_future

  private

  def validity_date_is_future
    if self.validity_date.present? && self.validity_date <= Date.today
      self.errors.add(:validity_date, 'deve ser futura.')
    end
  end
end
