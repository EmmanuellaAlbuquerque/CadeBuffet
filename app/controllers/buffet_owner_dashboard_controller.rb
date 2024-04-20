class BuffetOwnerDashboardController < ApplicationController
  def index
    if !current_buffet_owner.buffet.present?
      return redirect_to new_buffet_path
    end

    @buffet = current_buffet_owner.buffet
    @buffet_payment_methods = @buffet.payment_methods
    @events = @buffet.events
  end
end