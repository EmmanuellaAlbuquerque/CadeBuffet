class PenaltiesController < ApplicationController
  def new
    @event = Event.find_by(id: params[:event_id])
    @penalty = Penalty.new
  end

  def create
    @event = Event.find_by(id: params[:event_id])
    @penalty = @event.penalties.new(penalty_params)

    if @penalty.save
      redirect_to @penalty.event, notice: 'Multa cadastrada com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível cadastrar a Multa.'
      render :new  
    end
  end

  private

  def penalty_params
    params.require(:penalty).permit(
      :days_ago,
      :value_percentage,
    )
  end
end