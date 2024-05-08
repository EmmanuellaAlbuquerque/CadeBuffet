class Api::V1::BuffetsController < ActionController::API
  def index
    query = params[:query]

    if query
      buffets = Buffet.alphabetic_search(query)
    else
      buffets = Buffet.all
    end
    render status: 200, json: buffets
  end
end
