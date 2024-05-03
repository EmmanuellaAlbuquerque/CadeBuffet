class OrdersController < ApplicationController
  before_action :authenticate_client!, except: [:show]
  before_action :authorize_client_or_buffet_owner, only: [:show]

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

    @same_date_orders = Order.where('id != ? AND event_date = ? AND status = ?', @order.id, @order.event_date, Order.statuses[:confirmed]).limit(10)
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

  def authorize_client_or_buffet_owner
    unless current_client || current_buffet_owner
      flash[:alert] = "Você não tem permissão para acessar esta página."
      redirect_to root_path
    end
  end
end
