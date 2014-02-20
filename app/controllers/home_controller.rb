class HomeController < ApplicationController
  def index
    redirect_to new_user_registration_path unless user_signed_in?
  end
end
