class EventsController < ApplicationController
  def new
    @event = Event.new
    @service_options = ServiceOption.all
  end

  private 

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :qty_min,
      :qty_max,
      :duration,
      :menu,
      service_option_ids: []
    )
  end
end