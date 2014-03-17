class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :signed_in
    end
  end
end
