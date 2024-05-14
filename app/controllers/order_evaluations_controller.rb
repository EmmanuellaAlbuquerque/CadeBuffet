class OrderEvaluationsController < ApplicationController
  def create
    order_evaluation = OrderEvaluation.new(order_evaluation_params)

    if order_evaluation.save
      redirect_to order_path(id: order_evaluation_params[:order_id]), notice: 'Avaliação salva com sucesso!'
    end
  end

  def index
    begin
      buffet_id = Integer(params[:buffet_id])
    rescue
      return redirect_to root_path
    end
    @buffet = Buffet.find(buffet_id)
    @reviews = OrderEvaluation.by_buffet(@buffet)
  end

  private

  def order_evaluation_params
    params.require(:order_evaluation).permit(
      :rating,
      :service_opinion,
      :order_id
    )
  end
end