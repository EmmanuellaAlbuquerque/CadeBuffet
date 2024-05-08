class Api::V1::EventsController < Api::V1::ApiController
  def index
    buffet = Buffet.find(params[:buffet_id])
    events = buffet.events
    render status: 200, json: events
  end
end