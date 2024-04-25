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
  numericality: { only_integer: true }
  
  has_many :event_service_options
  has_many :service_options, through: :event_service_options
  has_many :base_prices
  has_many_attached :photos
  
  belongs_to :buffet
end
