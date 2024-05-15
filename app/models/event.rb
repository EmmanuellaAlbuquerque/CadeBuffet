class Event < ApplicationRecord
  belongs_to :buffet
  enum status: { deactive: 0, active: 1 }
  
  has_many :event_service_options
  has_many :service_options, through: :event_service_options
  has_many :base_prices
  has_many_attached :photos
  has_many :orders
  
  validates :name, 
  :description,
  :qty_min,
  :qty_max,
  :duration,
  :menu,
  presence: true

  validates :name, uniqueness: { scope: :buffet_id, message: ': Você já cadastrou um evento com esse nome!' }

  validates :qty_min, 
  :qty_max,
  numericality: { only_integer: true, greater_than: 0 }

  validates :duration,
  numericality: { greater_than: 0 }

  validates :qty_max, comparison: { greater_than_or_equal_to: :qty_min }
end
