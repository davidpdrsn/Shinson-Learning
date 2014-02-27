class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def timestamp(record, method = :created_at)
    date = record.send(method)
    "#{date.to_formatted_s(:short)} (#{view_context.time_ago_in_words date} ago)"
  end
  helper_method :timestamp

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation, :current_password,
               :email, :first_name, :last_name)
    end
  end

  def get_technique
    @technique = current_user.techniques.find(params[technique_param_key])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Technique not found"
    redirect_to root_path
  end
end
