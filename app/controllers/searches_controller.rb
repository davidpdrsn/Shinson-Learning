class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # TODO: extract some kind of searcher class that does the SQL stuff
  def create
    sql_query = params[:query].split("").join("%")
    results = current_user.techniques.where 'name ILIKE ?', "%#{sql_query}%"

    respond_to do |format|
      format.json { render json: results }
      format.html {
        @results = SearchResult.new(params[:query], results)
        render :show
      }
    end
  end
end
