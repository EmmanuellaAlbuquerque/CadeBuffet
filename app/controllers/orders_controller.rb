class OrdersController < ApplicationController
  before_action :authenticate_client!, except: [:show]
  before_action :set_order_and_check_user, only: [:show, :confirmed, :canceled]

  def new
    @event = Event.find(params[:event_id])
    return redirect_to root_path if @event.deactive?

    @buffet = Buffet.find(@event.buffet_id)
    return redirect_to root_path, alert: 'Buffet não encontrado!' if @buffet.deactive?
    
    @order = Order.new
  end

  def create
    @event = Event.find(params[:event_id])
    @order = @event.orders.build(order_params.merge(client: current_client, buffet_id: @event.buffet_id))
    
    if @order.save
      Chat.create(order: @order)
      redirect_to @order, notice: 'Pedido solicitado com sucesso!'
    else
      flash.now[:error] = 'Não foi possível solicitar o Pedido de Evento!'
      render :new
    end
  end

  def show
    @message = Message.new
    @messages = @order.chat&.messages
    @can_evaluate = can_evaluate_order?(@order)
    get_today_penalty()

    if current_buffet_owner
      load_same_date_orders()
      @payment_methods = current_buffet_owner.buffet.payment_methods
    end

    load_order_payment()
    if !@order_payment.new_record?
      return
    end

    calculate_standard_price()
  end

  def index
    @orders = current_client.orders
  end

  def confirmed
    @order_payment = OrderPayment.find_by(order_id: @order.id)
    if Date.current <= @order_payment.validity_date
      @order.confirmed!
      redirect_to @order, notice: 'Pedido confirmado com sucesso!'
    else
      @message = Message.new
      flash.now[:alert] = 'Não foi possível confirmar o pedido. Por favor, entre em contato com o Dono de Buffet para ajustar a data limite ou faça um novo pedido.'
      render :show
    end
  end

  def canceled
    @order.canceled!
    redirect_to @order, notice: 'Pedido cancelado com sucesso!'
  end

  private

  def order_params
    params
    .require(:order)
        .permit(:event_date, :qty_invited, :event_details, :event_address)
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])

    unless @order.client == current_client || @order.buffet.buffet_owner == current_buffet_owner
      return redirect_to root_path, alert: 'Você não possui acesso a este pedido!'
    end
  end

  def can_evaluate_order?(order)
    order_evaluation = OrderEvaluation.find_by(order_id: @order.id)
    order.confirmed? && Date.current > order.event_date && order_evaluation.nil?
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

    @sale_discount = calculate_sale_discount()
    @event_standard_price = (@base_price.min_price + extra_price_per_people) - @sale_discount
  end

  def calculate_sale_discount
    discount_percentage = 0
    sales = Sale.where("event_id = ? AND start_date <= ? AND end_date >= ?", @order.event, Date.current, Date.current).order(discount_percentage: :desc)
    chosen_category_day = @order.event_date.on_weekend? ? :weekend : :weekdays
    weekday_sale = sales.find_by(on_weekdays: true)
    weekend_sale = sales.find_by(on_weekend: true)

    if chosen_category_day == :weekdays && weekday_sale
      discount_percentage = weekday_sale.discount_percentage
    elsif chosen_category_day == :weekend && weekend_sale
      discount_percentage = weekend_sale.discount_percentage
    end

    if discount_percentage > 0
      @base_price.min_price * (discount_percentage/100.0)
    else
      discount_percentage
    end
  end

  def load_order_payment
    @order_payment = OrderPayment.find_by(order_id: @order.id) || OrderPayment.new
  end

  def load_same_date_orders
    @same_date_orders = Order.confirmed_same_date_orders(@order).limit(5)
  end

  def get_today_penalty
    days_until_event = (@order.event_date - Date.current).to_i

    penalty = Penalty.where('event_id = ? AND days_ago >= ?', @order.event, days_until_event).order(days_ago: :asc).limit(1).first

    if penalty.nil?
      @total_penalty = 'cancelar o pedido não irá gerar multa'
    else
      @total_penalty = (@order.order_payment.standard_price + @order.order_payment.extra_tax - @order.order_payment.discount) * (penalty.value_percentage/100.0)
      @penalty_percentage = "(#{penalty.value_percentage}%)"
    end
  end
end
