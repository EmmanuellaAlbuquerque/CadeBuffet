class EventBasePrice < ApplicationRecord
  validates :min_price,
  :chosen_category_day,
  :extra_price_per_person,
  :extra_price_per_duration,
  presence: true

  validates :min_price,
  :extra_price_per_person,
  :extra_price_per_duration,
  numericality: true
  
  validates :chosen_category_day, 
  uniqueness: { scope: :event_id, message: ': Você já cadastrou a Precificação durante esse %{attribute}.' }
  
  belongs_to :event
  enum chosen_category_day: { weekdays: 2, weekend: 5 }
end
