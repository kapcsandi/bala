class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('successfully_logged_in')
      event_logger("#{params[:user_session][:username]} belépett a #{request.remote_ip} IP címről")
      redirect_to event_logs_url
    else
      logger.warn("sikertelen belépés: #{params[:user_session].inspect}")
      event_logger("sikertelen belépés: #{params[:user_session][:username]} a #{request.remote_ip} IP címről")
      flash[:error] = t('admin.user_login_error')
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    begin
      event_logger("#{current_user.username} kilépett")
      @user_session.destroy
    rescue
      logger.info "#{Time.now} hiba a kilépés során: #{$!.to_s}"
    end
    flash[:notice] = t('successfully_logged_out')
    redirect_to root_url
  end
end
