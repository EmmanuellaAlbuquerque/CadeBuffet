class OrderEvaluation < ApplicationRecord
  belongs_to :order
  has_many_attached :review_medias

  validates :order, uniqueness: true

  def self.by_buffet(buffet)
    OrderEvaluation.joins(order: [:buffet, :client])
                    .select('order_evaluations.*, buffets.id AS buffet_id, clients.name AS client_name')
                    .where('buffets.id = ?', buffet.id)
                    .order(created_at: :desc)
  end
end
