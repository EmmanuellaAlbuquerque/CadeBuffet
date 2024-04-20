class BasePricesController < ApplicationController
  before_action :authenticate_buffet_owner!

  def new
    @base_price = BasePrice.new
  end

  private

  def base_price_params
    params.require(:base_price).permit(
      :min_price,
      :chosen_category_day,
      :extra_price_per_person,
      :extra_price_per_duration
    )
  end
  
end