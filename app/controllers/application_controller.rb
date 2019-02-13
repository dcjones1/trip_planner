class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_cart

  def current_cart
    session[:current_cart] ||= []
  end
end
