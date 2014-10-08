class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # TODO: extract some kind of searcher class that does the SQL stuff
  def create
    sql_query = params[:query].split("").join("%")
    result = current_user.techniques.where 'name ILIKE ?', "%#{sql_query}%"

    render json: result
  end
end
