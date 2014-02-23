module SessionsHelper

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def sign_in_user(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end

  def sign_out_user(user)
    user.reset_session_token!
    session[:token] = nil
    @current_user = nil
  end

  def user_is_admin?
    current_user && current_user.admin?
  end

  def require_signed_in
    unless current_user
      redirect_to '/'
    end
  end

  def require_signed_out
    if current_user
      redirect_to '/'
    end
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to '/'
    end
  end

end
