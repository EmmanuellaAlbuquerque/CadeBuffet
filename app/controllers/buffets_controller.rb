class BuffetsController < ApplicationController
  before_action :authenticate_buffet_owner!
  before_action :buffet_exists?, only: [:new, :create]
  before_action :set_buffet_and_check_owner, only: [:edit, :update]

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
      flash.now[error] = 'Não foi possível atualizar o buffet.'
      render :edit
    end 
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
end