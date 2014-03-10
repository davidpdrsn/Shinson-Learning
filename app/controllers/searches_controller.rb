class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    result = current_user.techniques.where 'name ILIKE ?', "%#{params[:query]}%"

    render json: result
  end
end
