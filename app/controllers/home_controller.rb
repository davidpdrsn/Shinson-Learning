class HomeController < ApplicationController
  def index
    if user_signed_in?
      @neglected_studies = current_user.neglected_studies
      render :signed_in
    end
  end
end
