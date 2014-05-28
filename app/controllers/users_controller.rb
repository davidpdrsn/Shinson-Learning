class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def show
    @page_title = "#{UserPresenter.new(@user).name_with_s} profile"
    @user_cache = UserCache.new @user
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
