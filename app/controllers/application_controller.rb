# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  helper_method :current_user
  before_filter :set_locale
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def set_locale 
    #if params[:locale] is nil then I18n.default_locale will be used  
    # I18n.locale = extract_locale_from_uri
    
    I18n.locale = params[:locale] if params[:locale]
    #	params[:locale] 
  end 
    
  def extract_locale_from_uri 
    parsed_locale = request.host.split('.').last 
    (I18n.backend.available_locales.include? parsed_locale) ? parsed_locale : nil 
  end 
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
end
