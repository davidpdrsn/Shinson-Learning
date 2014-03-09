class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    result = current_user.techniques.select do |t|
      t.name.match /#{params[:query]}/i
    end

    render json: result
  end
end
