class ApplicationController < ActionController::Base

  helper_method :log_in, :current_user, :logged_in?, :log_out

  def log_in(user)
    session[:user_id] = user.id
    user.update_attribute(:updated_at, Time.zone.now)
  end

  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    redirect_to (logged_in? ? current_user : root_path)
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
