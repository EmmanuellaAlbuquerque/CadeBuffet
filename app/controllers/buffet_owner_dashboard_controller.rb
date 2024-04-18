class BuffetOwnerDashboardController < ApplicationController
  def index
    if !current_buffet_owner.buffet.present?
      return redirect_to new_buffets_path
    end

    @buffet = current_buffet_owner.buffet
  end
end