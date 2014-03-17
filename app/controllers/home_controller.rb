class HomeController < ApplicationController
  def index
    if user_signed_in?
      @neglected_studies = Study.neglected_for_user current_user
      render :signed_in
    end
  end
end
