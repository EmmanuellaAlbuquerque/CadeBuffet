class Sale < ApplicationRecord
  belongs_to :buffet
  belongs_to :event

  validates :name, :start_date, :end_date, :discount_percentage, presence: true
  validate :verify_start_date
  validate :verify_end_date

  validates :discount_percentage,
  numericality: { only_integer: true, greater_than: 0 }

  private

  def verify_start_date
    if self.start_date.present? && self.start_date <= Date.today
      self.errors.add(:start_date, 'deve ser futura.')
    end
  end

  def verify_end_date
    if self.start_date && self.end_date && end_date <= start_date
      self.errors.add(:end_date, "deve ser maior que a Data de Início")
    end
  end
end
