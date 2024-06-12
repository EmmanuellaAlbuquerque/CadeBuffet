class Buffet < ApplicationRecord
  belongs_to :buffet_owner

  enum status: { deactive: 0, active: 1 }

  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  has_many :events
  has_many :orders
  has_many :sales

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
            :description, :payment_methods, presence: true

  validates :state, length: { is: 2 }
  validates :description, length: { maximum: 300 }
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :zipcode,
    length: { is: 9 }, format: { with: /\A\d{5}-\d{3}\z/,
    message: "não é válido, deve ter o formato XXXXX-YYY" }
  validates :phone, 
    format: { with: /\A\(\d{2}\) \d \d{4}-\d{4}\z/ ,
    message: "não é válido, deve ter o formato (YY) X XXXX-XXXX" }

  def self.search(query)
    Buffet.distinct.left_joins(:events)
      .where("buffets.status = :status AND (buffets.trading_name LIKE :query OR buffets.city LIKE :query OR events.name LIKE :query)", 
      status: Buffet.statuses[:active], 
      query: "%#{query}%")
  end

  def self.alphabetic_search(query)
    self.search(query).order(:trading_name)
  end  
end

