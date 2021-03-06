module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token]=user.remember_token
    self.current_user=user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user=user
  end

  def current_user
    @current_user ||=User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user==current_user
  end

  def sign_out
    self.current_user=nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to]||default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to]=request.url
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end  
  end

  def power_user
    redirect_to(root_path) unless current_user.poweruser?
  end
  
  def can_view_else_redirect (company)
    if (company.teams & current_user.teams).empty?
      unless company.poc_id == current_user.id
        unless current_user.admin?
          flash[:error]="Access Denied"
          redirect_to goback 
        end
      end
    end
  end

  def goback
    if request.referrer
      request.referrer
    else
      root_path
    end
  end
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
