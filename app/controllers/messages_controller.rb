class MessagesController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @message = Message.new(message_params)
    @message.chat = @order.chat
    @message.sender = current_client || current_buffet_owner

    if @message.save
      redirect_to @order, notice: 'Mensagem enviada com sucesso!'
    else
      flash.now[:error] = 'Não foi possível enviar a mensagem!'
      render 'orders/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end