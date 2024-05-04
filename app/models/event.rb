class Event < ApplicationRecord
  validates :name, 
  :description,
  :qty_min,
  :qty_max,
  :duration,
  :menu,
  presence: true

  validates :qty_min, 
  :qty_max,
  numericality: { only_integer: true, greater_than: 0 }

  validates :duration,
  numericality: { greater_than: 0 }

  validates :qty_max, comparison: { greater_than_or_equal_to: :qty_min }
  
  has_many :event_service_options
  has_many :service_options, through: :event_service_options
  has_many :base_prices
  has_many_attached :photos
  has_many :orders
  
  belongs_to :buffet
end
