class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :user_logged_in?
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :add_www

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def add_www
    redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host)
  end

  def user_logged_in?
    !!current_user
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_admin
    unless current_user && current_user.admin?
      store_location
      render_404; return false # act like it doesn't exist
    end
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def allow_blanks(params, *fields)
    fields.each do |field|
      next unless params.has_key?(field)
      params[field] = nil if params[field].blank?
    end
    params
  end
  
  def render_optional_error_file(status_code)
    if status_code == :not_found
      render_404
    else
      render_error status_code
    end
  end

  def render_error(status_code = 500)
    respond_to do |type|
      type.html { render :template => 'errors/general', :status => status_code }
      type.all { render :nothing => true, :status => status_code }
    end
    true
  end
  
  def render_404
    respond_to do |type|
      type.html { render :template => 'errors/404', :status => 404 }
      type.all  { render :nothing => true, :status => 404 }
    end
    true
  end
    
end
