class BuffetsController < ApplicationController
  before_action :authenticate_buffet_owner!, only: [:new, :create, :edit, :update]
  before_action :buffet_exists?, only: [:new, :create]
  before_action :set_buffet_and_check_owner, only: [:edit, :update, :orders, :deactivate, :activate]

  def show
    @buffet = Buffet.find_by_id(params[:id])

    if @buffet.nil?
      return redirect_to root_path
    elsif @buffet.deactive?
      return redirect_to root_path, alert: 'Buffet não encontrado!'
    end
    
    @events = @buffet.events.active
    @average_rating = calculate_average_rating(@buffet)
  end

  def search
    @query = params[:query]
    @buffets = Buffet.alphabetic_search(@query)
    @buffets_count = @buffets.count
  end

  def orders
    orders = @buffet.orders
    @pending_orders, @other_orders = orders.partition { |order| order.status == 'pending' }
  end

  def new
    @buffet = Buffet.new
    @payment_methods = PaymentMethod.all
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_owner = current_buffet_owner

    if @buffet.save
      redirect_to root_path, notice: 'Buffet cadastrado com sucesso.'
    else
      @payment_methods = PaymentMethod.all
      flash.now[:error] = 'Buffet não cadastrado.'
      render :new
    end
  end

  def edit
    @payment_methods = PaymentMethod.all    
  end

  def update
    if @buffet.update(buffet_params)
      redirect_to owner_dashboard_path, notice: 'Buffet atualizado com sucesso.'
    else
      @payment_methods = PaymentMethod.all
      flash.now[:error] = 'Não foi possível atualizar o buffet.'
      render :edit
    end 
  end

  def deactivate
    @buffet.deactive!
    redirect_to owner_dashboard_path, alert: 'O seu Buffet foi desativado!'
  end
  
  def activate
    @buffet.active!
    redirect_to owner_dashboard_path, alert: 'O seu Buffet foi reativado com sucesso!'
  end

  private

  def buffet_exists?
    if current_buffet_owner.buffet.present?
      redirect_to owner_dashboard_path, notice: 'Você já cadastrou o seu Buffet.'
    end
  end

  def buffet_params
    params.require(:buffet)
      .permit(
        :trading_name, 
        :company_name,
        :registration_number, 
        :phone, 
        :email, 
        :address, 
        :neighborhood, 
        :state, 
        :city, 
        :zipcode, 
        :description,
        payment_method_ids: []
        )
  end

  def set_buffet_and_check_owner
    @buffet = Buffet.find(params[:id])

    if @buffet.buffet_owner != current_buffet_owner
      redirect_to owner_dashboard_path, notice: 'Você não possui acesso a esse Buffet!'
    end
  end

  def calculate_average_rating(buffet)
    sum = 0
    orders_evaluations = OrderEvaluation.by_buffet(buffet)
    return "Ainda não foram cadastradas avaliações!" if orders_evaluations.length.zero?

    @reviews = orders_evaluations.limit(3)
    @have_more_reviews = orders_evaluations.length > 3 ? true : false

    orders_evaluations.each do |order_evaluation|
      sum += order_evaluation.rating
    end

    sum.to_f/orders_evaluations.length
  end
end