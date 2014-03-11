class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    sql_query = params[:query].split("").join("%")
    result = current_user.techniques.where 'name ILIKE ?', "%#{sql_query}%"

    render json: result
  end
end
