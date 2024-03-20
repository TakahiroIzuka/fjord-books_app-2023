# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    books_path
  end

  def after_sign_out_path_for(resource)
    user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :post_code, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :post_code, :introduction])
  end
end
