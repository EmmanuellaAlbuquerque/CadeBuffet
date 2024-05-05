class OrdersController < ApplicationController
  before_action :authenticate_client!, except: [:show]
  before_action :authorize_client_or_buffet_owner, only: [:show]

  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @event = Event.find(params[:event_id])
    @order = @event.orders.build(order_params.merge(client: current_client, buffet_id: @event.buffet_id))
    
    if @order.save
      redirect_to @order, notice: 'Pedido solicitado com sucesso!'
    else
      flash.now[:error] = 'Não foi possível solicitar o Pedido de Evento!'
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])

    if current_buffet_owner
      load_same_date_orders()
      @payment_methods = current_buffet_owner.buffet.payment_methods
    end

    load_order_payment()
    if @has_approved_order
      return
    end

    calculate_standard_price()
  end

  def index
    @orders = current_client.orders
  end

  def confirmed
    @order = Order.find(params[:id])
    @order.confirmed!
    redirect_to @order
  end

  def canceled
    @order = Order.find(params[:id])
    @order.canceled!
    redirect_to @order
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

  def set_base_price_for_chosen_day
    chosen_category_day = @order.event_date.on_weekend? ? :weekend : :weekdays
    @base_price = @order.event.base_prices.where('chosen_category_day = ?', BasePrice.chosen_category_days[chosen_category_day]).first
  end

  def calculate_standard_price
    set_base_price_for_chosen_day()
    return unless @base_price.present?

    extra_price_per_people = 0
    if @order.qty_invited > @order.event.qty_min
      extra_people = @order.qty_invited - @order.event.qty_min
      extra_price_per_people = @base_price.extra_price_per_person * extra_people
    end
    @event_standard_price = @base_price.min_price + extra_price_per_people
  end

  def load_order_payment
    @order_payment = OrderPayment.find_by(order_id: @order.id) || OrderPayment.new
    @has_approved_order = !@order_payment.new_record?
  end

  def load_same_date_orders
    @same_date_orders = Order.confirmed_same_date_orders(@order).limit(10)
  end
end
