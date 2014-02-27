class UsersController < ApplicationController
  before_action :get_user, only: [:show]

  def show
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name, :email
  end

  def get_user
    @user = User.find(params[:id])
  end
end
