class BasePricesController < ApplicationController
  before_action :authenticate_buffet_owner!

  def new
    @event_base_price = EventBasePrice.new
  end

  def create
    @event_base_price = EventBasePrice.new(event_base_price_params)
    @event_base_price.event = Event.find(params[:event_id])

    if @event_base_price.save
      redirect_to event_path(@event_base_price.event_id), notice: 'Preço Base cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Preço Base não cadastrado.'
      render :new
    end
  end

  private

  def event_base_price_params
    params.require(:event_base_price).permit(
      :min_price,
      :chosen_category_day,
      :extra_price_per_person,
      :extra_price_per_duration
    )
  end  
end