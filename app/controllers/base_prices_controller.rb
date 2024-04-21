class BasePricesController < ApplicationController
  before_action :authenticate_buffet_owner!
  before_action :set_base_price_and_check_owner, only: [:show, :edit, :update]

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

  def show
    @qty_min = Event.find(params[:event_id]).qty_min
    @base_price = EventBasePrice.find(params[:id])
  end

  def edit
    @event_base_price = EventBasePrice.find(params[:id])
  end

  def update
    @event_base_price = EventBasePrice.find(params[:id])
    
    if @event_base_price.update(event_base_price_params)
      redirect_to event_base_price_path(params[:event_id]), notice: 'Preço base atualizado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizar o preço base.'
      render :edit
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

  def set_base_price_and_check_owner
    @event_base_price = EventBasePrice.find(params[:id])

    if current_buffet_owner != @event_base_price.event.buffet.buffet_owner
      redirect_to owner_dashboard_path, notice: 'Você não possui acesso a esse Preço Base!'
    end
  end
end