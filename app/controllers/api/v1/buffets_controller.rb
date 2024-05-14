class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    query = params[:query]

    if query
      buffets = Buffet.alphabetic_search(query)
    else
      buffets = Buffet.active
    end
    render status: 200, json: buffets.as_json(except: [:created_at, :updated_at, :status])
  end

  def show
    buffet = Buffet.find(params[:id])

    if buffet.active?
      render status: 200, 
            json: buffet.as_json(except: [:company_name, :registration_number, :created_at, :updated_at, :status],
                                  include: { payment_methods: { only: :name } })
    else
      render status: 404
    end
  end
end
