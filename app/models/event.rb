class Event < ApplicationRecord
  has_many :event_service_options
  has_many :service_option, through: :event_service_options

  belongs_to :buffet
end
