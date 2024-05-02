class OrdersController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @event = Event.find(params[:event_id])
    @order = Order.new(order_params)
    @order.event = @event
    @order.buffet_id = @event.buffet_id
    @order.client = current_client
    
    if @order.save
      redirect_to @order, notice: 'Pedido solicitado com sucesso!'
    else
      flash.now[:error] = 'Não foi possível solicitar o Pedido de Evento!'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_client.orders
  end

  private

  def order_params
    params
    .require(:order)
        .permit(:event_date, :qty_invited, :event_details, :event_address)
  end
end
