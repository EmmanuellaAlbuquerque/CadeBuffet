class EventBasePrice < ApplicationRecord
  belongs_to :event

  enum chosen_category_day: { weekdays: 2, weekend: 5 }
end
