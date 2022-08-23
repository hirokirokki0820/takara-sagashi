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
    if !logged_in?
      if Rails.env.production?
        # 本番環境のみの処理
        redirect_to "https://qr-treasure-hunt.herokuapp.com", alert: "ログインしてください"
      elsif Rails.env.development?
        # 開発環境のみの処理
        redirect_to root_path, alert: "ログインしてください"
      end
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
