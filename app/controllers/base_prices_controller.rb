class BasePricesController < ApplicationController
  before_action :authenticate_buffet_owner!
  before_action :set_base_price_and_check_owner, only: [:show, :edit, :update]

  def new
    @base_price = BasePrice.new
    @event = Event.find(params[:event_id])
  end

  def create
    @base_price = BasePrice.new(base_price_params)
    @base_price.event = Event.find(params[:event_id])
    @event = Event.find(params[:event_id])

    if @base_price.save
      redirect_to base_price_path(@base_price.id), notice: 'Preço Base cadastrado com sucesso.'
    else
      flash.now[:error] = 'Preço Base não cadastrado.'
      render :new
    end
  end

  def show
    @base_price = BasePrice.find(params[:id])
    @event = Event.find(@base_price.event_id)
  end

  def edit
    @base_price = BasePrice.find(params[:id])
  end

  def update
    @base_price = BasePrice.find(params[:id])
    
    if @base_price.update(base_price_params)
      redirect_to base_price_path(@base_price.id), notice: 'Preço base atualizado com sucesso.'
    else
      flash.now[:error] = 'Não foi possível atualizar o preço base.'
      render :edit
    end
  end

  private

  def base_price_params
    params.require(:base_price).permit(
      :min_price,
      :chosen_category_day,
      :extra_price_per_person,
      :extra_price_per_duration
    )
  end  

  def set_base_price_and_check_owner
    @base_price = BasePrice.find(params[:id])

    if current_buffet_owner != @base_price.event.buffet.buffet_owner
      redirect_to owner_dashboard_path, notice: 'Você não possui acesso a esse Preço Base!'
    end
  end
end