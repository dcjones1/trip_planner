module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def log_out
    reset_session
  end

  def current_trip
    if session[:trip_id]
      @trip = Trip.find_by(id: session[:trip_id])
    end
  end
end
