class Event < ApplicationRecord
  validates :name, 
  :description,
  :qty_min,
  :qty_max,
  :duration,
  :menu,
  presence: true
  
  has_many :event_service_options
  has_many :service_options, through: :event_service_options
  has_many :event_base_prices
  
  belongs_to :buffet
end
