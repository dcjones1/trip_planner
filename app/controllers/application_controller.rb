class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_cart

  def current_cart
    session[:current_cart] ||= []
  end

  def rootmaker
    if !logged_in?
      redirect_to login_path
    end
  end

  def tripmaker
    if session[:trip_id].nil?
      redirect_to new_trip_path
    end
  end
end
