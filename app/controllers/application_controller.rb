class ApplicationController < ActionController::Base

  helper_method :log_in, :current_user, :logged_in?, :remember, :forget, :log_out

  def log_in(user)
    session[:user_id] = user.id
    user.update_attribute(:updated_at, Time.zone.now)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
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

  # ユーザーのセッションをcookieに保存する（永続的セッション）
  def remember(user)
    user.remember
    cookies.encrypted[:user_id] = { value: user.id, expires: 1.month.from_now }
    cookies[:remember_token] = { value: user.remember_token, expires: 1.month.from_now }
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウトする（セッション情報を削除する）
  def log_out
    # ログアウト時に current_user の永続的セッションも破棄する
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
