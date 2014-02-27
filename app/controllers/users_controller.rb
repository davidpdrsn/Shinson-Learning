class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :show, :update, :destroy]
  before_action :enfore_user!, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    redirect_to @user, notice: "Updated"
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "Account deleted"
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name, :email
  end

  def get_user
    @user = User.find(params[:id])
  end

  def enfore_user!
    unless current_user == @user
      redirect_to @user, alert: "You can only edit your own account"
    end
  end
end
