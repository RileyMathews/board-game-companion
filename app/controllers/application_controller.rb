class ApplicationController < ActionController::Base
  extend Lettable
  before_action :configure_permitted_parameters, if: :devise_controller?
  check_authorization unless: :devise_controller?

protected

  def configure_permitted_parameters
    added_attrs = %i(username email password password_confirmation remember_me)
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i(login password)
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def current_ability
    @current_ability ||= Ability.new current_user
  end
end
