class EventsController < ApplicationController
  before_action :authenticate_buffet_owner!

  def new
    @event = Event.new
    @service_options = ServiceOption.all
  end

  def create
    @event = Event.new(event_params)
    @event.buffet = current_buffet_owner.buffet
    
    if @event.save
      redirect_to owner_dashboard_path, notice: 'Evento cadastrado com sucesso.'
    else
      @service_options = ServiceOption.all
      flash.now[:notice] = 'Evento não cadastrado'
      render :new
    end
  end

  def edit
  end

  def update
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