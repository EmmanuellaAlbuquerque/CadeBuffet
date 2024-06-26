class OrderPaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @order_payment = OrderPayment.new(order_payments_params)
    @order_payment.order_id = @order.id

    if @order_payment.save
      @order.approved!
      redirect_to order_path(@order.id), notice: 'Pedido aprovado com sucesso!'
    else
      load_dependencies()
      flash.now[:error] = 'Não foi possível aprovar o pedido.'
      render 'orders/show'
    end
  end

  def update
    @order_payment = OrderPayment.find(params[:id])

    if Order.statuses[:confirmed]
      @order = @order_payment.order
      load_dependencies()
      flash.now[:error] = 'Não foi possível atualizar o Preço. O cliente já confirmou o pedido!'
      return render 'orders/show'
    end

    if @order_payment.update(order_payments_params)
      redirect_to order_path(params[:order_id]), notice: 'Aprovação do Pedido atualizada com sucesso!'
    else
      @order = @order_payment.order
      load_dependencies()
      flash.now[:error] = 'Não foi possível atualizar a aprovação do pedido.'
      render 'orders/show'
    end
  end

  private

  def order_payments_params
    params
      .require(:order_payment)
        .permit(:extra_tax,
                :discount,
                :description,
                :validity_date,
                :payment_method_id,
                :standard_price,
                :special_sale
               )
  end

  def load_dependencies
    @payment_methods = current_buffet_owner.buffet.payment_methods
    @event_standard_price = @order_payment.standard_price
    @message = Message.new
    @messages = @order.chat&.messages
  end
end
