class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, polymorphic: true
end
