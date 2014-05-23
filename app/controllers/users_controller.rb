class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def show
    @user_cache = UserCache.new @user
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
