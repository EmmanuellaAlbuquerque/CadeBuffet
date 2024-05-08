class Api::V1::EventsController < ActionController::API
  def index
    buffet = Buffet.find(params[:buffet_id])
    events = buffet.events
    render status: 200, json: events
  end
end