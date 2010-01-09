# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :logged_in?, :admin?
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  helper_method :current_user, :event_logger
  before_filter :authenticate
  before_filter :set_locale
  before_filter :current_user, :only => [:logged_in?, :admin?]
  
  private

  def authenticate
    return true unless APP_CONFIG['perform_authentication']
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG['username'] && password == APP_CONFIG['password']
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def logged_in?
    current_user
  end
  
  def admin?
    current_user
  end
  
  def authorize
    unless logged_in?
      flash[:error] = t('unrestricted_access')
      redirect_to :root
    end
  end
  
  def set_locale 
    #if params[:locale] is nil then I18n.default_locale will be used  
    # I18n.locale = extract_locale_from_uri

    I18n.locale = params[:locale] || cookies[:locale] || :de
    cookies[:locale] = params[:locale] if params[:locale]
  end
    
  def extract_locale_from_uri 
    parsed_locale = request.host.split('.').last 
    (I18n.backend.available_locales.include? parsed_locale) ? parsed_locale : nil 
  end 
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  def empties_helper
    empties = House.column_names.select{|name| name.match(/_id/) }
    empties += ['accomodation', 'room_types_ground', 
	      'room_types_1st_floor', 'room_types_2nd_floor', 
	      'room_types_mansard', 'owner_speaks', 
	      'category', 'hidden_tags']
    empties.select{|field| Taggable.find_by_field(field).nil? }
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def event_logger(action)
    EventLog.new(:user_id => User.find(current_user).id, :action => action).save!
  end
end
