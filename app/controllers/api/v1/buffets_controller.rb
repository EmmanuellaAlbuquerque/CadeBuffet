class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    query = params[:query]

    if query
      buffets = Buffet.alphabetic_search(query)
    else
      buffets = Buffet.all
    end
    render status: 200, json: buffets
  end

  def show
    buffet = Buffet.find(params[:id])
    render status: 200, 
           json: buffet.as_json(except: [:company_name, :registration_number],
                                include: { payment_methods: { only: :name } })
  end
end
