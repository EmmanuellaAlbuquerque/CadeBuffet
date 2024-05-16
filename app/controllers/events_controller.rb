class EventsController < ApplicationController
  before_action :authenticate_buffet_owner!, except: [:show]
  before_action :set_event_and_check_owner, only: [:edit, :update, :deactivate, :activate]

  def new
    @event = Event.new
    @service_options = ServiceOption.all
  end

  def create
    @event = Event.new(event_params)
    @event.buffet = current_buffet_owner.buffet
    
    if @event.save
      redirect_to owner_dashboard_path, notice: 'Evento cadastrado com sucesso.'
    else
      @service_options = ServiceOption.all
      flash.now[:error] = 'Evento não cadastrado'
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @sales = Sale.where("event_id = ? AND start_date <= ?", @event, Date.current).order(discount_percentage: :desc)
    @on_weekdays_sale = @sales.where(on_weekdays: true).first
    @on_weekend_sale = @sales.where(on_weekend: true).first
  end

  def edit
    @service_options = ServiceOption.all
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event.id), notice: 'Evento atualizado com sucesso.'
    else
      @service_options = ServiceOption.all
      flash.now[:error] = 'Não foi possível atualizar o Evento.'
      render :edit
    end
  end

  def deactivate
    @event.deactive!
    redirect_to owner_dashboard_path, alert: "O seu evento \"#{@event.name}\" foi desativado!"
  end

  def activate
    @event.active!
    redirect_to owner_dashboard_path, alert: "O seu evento \"#{@event.name}\" foi reativado com sucesso!"
  end

  private 

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :qty_min,
      :qty_max,
      :duration,
      :menu,
      :exclusive_location,
      photos: [],
      service_option_ids: []
    )
  end

  def set_event_and_check_owner
    @event = Event.find(params[:id])

    if current_buffet_owner != @event.buffet.buffet_owner
      redirect_to owner_dashboard_path, notice: 'Você não possui acesso a esse Evento!'
    end
  end
end