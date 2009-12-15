class UsersController < ApplicationController
  before_filter :authorize, :except => [:new]
  before_filter :find_user, :only => [:edit, :update]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t('registration_successful')
      Notifications.deliver_signup(@user)
      redirect_to :root
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = t('admin.successfully_updated_profile')
      redirect_to :root
    else
      render :action => 'edit'
    end
  end

  private
  def find_user
    @user = current_user
  end
end
