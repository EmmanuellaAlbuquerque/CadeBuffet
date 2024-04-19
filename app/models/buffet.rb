class Buffet < ApplicationRecord
  validates :trading_name, 
            :company_name, 
            :registration_number, 
            :phone, 
            :email, 
            :address, 
            :neighborhood, 
            :state, 
            :city, 
            :zipcode, 
            :description, presence: true

  validates :state, length: { is: 2 }
  validates :description, length: { maximum: 300 }

  belongs_to :buffet_owner

  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
end
