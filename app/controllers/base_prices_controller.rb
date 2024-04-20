class BasePricesController < ApplicationController
  before_action :authenticate_buffet_owner!

  def new
  end
  
end