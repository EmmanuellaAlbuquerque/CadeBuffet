class Chat < ApplicationRecord
  belongs_to :order
  has_many :messages
end
