class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :itin, presence: true 
  validates :itin, uniqueness: true
  validate :itin_is_valid

  has_many :orders
  has_many :messages, as: :sender

  private

  def itin_is_valid
    unless CPF.valid?(self.itin)
      self.errors.add(:itin, 'deve ser válido XXX.XXX.XXX-YY')
    end
  end
end
