class SalesController < ApplicationController
  before_action :authenticate_buffet_owner!

  def new
    @sale = Sale.new
    @events = current_buffet_owner.buffet.events
  end

  def create
    @buffet = current_buffet_owner.buffet
    @sale = @buffet.sales.build(sale_params)

    if @sale.save
      redirect_to buffet_sales_path(@buffet), notice: 'Promoção salva com sucesso!'
    else
      @events = current_buffet_owner.buffet.events
      flash.now[:error] = 'Não foi possível registrar a Promoção'
      render :new
    end
  end

  def index
    @sales = current_buffet_owner.buffet.sales
  end

  private

  def sale_params
    params.require(:sale).permit(
      :name,
      :start_date,
      :end_date,
      :discount_percentage,
      :on_weekdays,
      :on_weekend,
      :event_id
    )
  end
end