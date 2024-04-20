class ServiceOption < ApplicationRecord
  has_many :event_service_options
  has_many :events, through: :event_service_options
end
