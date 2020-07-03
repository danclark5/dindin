class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_action_cable_identifier

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:preferred_timezone, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:preferred_timezone, :email, :password, :current_password)}
  end

  def set_action_cable_identifier
    cookies.encrypted[:user_id] = current_user&.id
  end
end
