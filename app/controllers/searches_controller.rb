class SearchesController < ApplicationController
  before_action :authenticate_user!, only: :index

  # TODO: extract some kind of searcher class that does the SQL stuff
  def index
    sql_query = params[:query].split("").join("%")
    results = current_user.techniques.where 'name ILIKE ?', "%#{sql_query}%"

    respond_to do |format|
      format.json { render json: results }
      format.html {
        @results = SearchResult.new(params[:query], results)
      }
    end
  end
end
