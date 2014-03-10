class LogsController < ApplicationController
  def create
    logger.info params[:message]
    render :nothing => true
  end
end
