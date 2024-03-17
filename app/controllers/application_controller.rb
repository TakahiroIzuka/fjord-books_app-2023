# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_local

  def switch_local(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
