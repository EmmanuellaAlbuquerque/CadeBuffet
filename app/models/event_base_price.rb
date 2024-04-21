class EventBasePrice < ApplicationRecord
  belongs_to :event

  validates :chosen_category_day, uniqueness: { scope: :event_id, message: ': Você já cadastrou a Precificação durante esse %{attribute}.' }

  enum chosen_category_day: { weekdays: 2, weekend: 5 }
end
