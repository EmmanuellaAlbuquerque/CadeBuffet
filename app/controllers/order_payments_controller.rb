class OrderPaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @order_payment = OrderPayment.new(order_payments_params)
    @order_payment.order_id = @order.id

    if @order_payment.save
      @order.approved!
      redirect_to order_path(@order.id), notice: 'Pedido aprovado com sucesso!'
    else
      @payment_methods = current_buffet_owner.buffet.payment_methods
      @event_standard_price = @order_payment.standard_price
      flash.now[:error] = 'Não foi possível aprovar o pedido.'
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
                :standard_price
               )
  end
end
