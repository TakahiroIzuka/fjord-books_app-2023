# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    books_path
  end

  def after_sign_out_path_for(resource)
    user_session_path
  end
end
