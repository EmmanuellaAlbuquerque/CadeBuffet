class HomeController < ApplicationController
  def index
    if current_buffet_owner
      redirect_to owner_dashboard_path
    end    
  end
end