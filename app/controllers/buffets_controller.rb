class BuffetsController < ApplicationController

  def new
    @buffet = Buffet.new   
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_owner = current_buffet_owner
    
    if @buffet.save
      redirect_to root_path, notice: 'Buffet cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Buffet não cadastrado.'
      render :new
    end
  end

  private

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
        :description
        )
  end
end