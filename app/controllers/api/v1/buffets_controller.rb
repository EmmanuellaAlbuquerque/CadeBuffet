class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    buffets = Buffet.active

    buffets_json = buffets.map do |buffet|
      buffet.as_json(except: [:created_at, :updated_at, :status, :company_name, :registration_number])
            .merge(average_rating: calculate_average_rating(buffet))
    end
    render status: 200, json: buffets_json
  end

  def search
    query = params[:query]
    buffets = Buffet.alphabetic_search(query)

    render status: 200, json: buffets.as_json(except: [:created_at, :updated_at, :status, :company_name, :registration_number])
  end

  def show
    buffet = Buffet.find(params[:id])

    if buffet.active?
      render status: 200, 
            json: buffet.as_json(except: [:company_name, :registration_number, :created_at, :updated_at, :status],
                                  include: { payment_methods: { only: :name } })
                        .merge(average_rating: calculate_average_rating(buffet))
    else
      render status: 404
    end
  end

  private

  def calculate_average_rating(buffet)
    orders_evaluations = OrderEvaluation.by_buffet(buffet)
    return "Ainda não foram cadastradas avaliações!" if orders_evaluations.empty?

    orders_evaluations.average(:rating).to_f
  end
end
