module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーを永続的セッションに記憶する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # # 現在ログイン中のユーザーを返す（いる場合）
  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])

  #   # # 上のコードと等価（データベースへの読み出しは最初の一回、以後はインスタンス変数を返す）
  #   # if @current_user.nil?
  #   #   @current_user = User.find_by(id: session[:user_id])
  #   # else
  #   #   @current_user
  #   # end

  #   # 上のコードと等価（メモ化）
  #   # @current_user = @current_user || User.find_by(id: session[:user_id])
  # end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  # （ユーザーがログイン中の状態とは、sessionにユーザーidが存在していること）
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # # 記憶したURL（もしくはデフォルト値）にリダイレクト
  # def redirect_back_or(default)
  #   redirect_to(session[:forwarding_url] || default)
  #   session.delete(:forwarding_url)
  # end

  # # アクセスしようとしたURLを覚えておく
  # def store_location
  #   session[:forwarding_url] = request.original_url if request.get?
  # end
end

