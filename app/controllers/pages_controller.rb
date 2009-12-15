class PagesController < ApplicationController
  before_filter :authorize, :except => [:show]
  before_filter :find_page, :only => [:edit, :update, :destroy]
  
  def index
    @pages = Page.all
  end
  
  def show
    if params[:id].to_s.to_i == 0
      page = params[:id]
      @page = Page.find_by_path(page.to_s)
    else
      find_page
    end
    if admin?
      if @page.nil?
        redirect_to new_page_path(:path => page)
      end
    elsif @page.nil? or not @page.published?
        redirect_to root_url
    end
  end
  
  def new
    @page = Page.new
    @page.path = params[:path] if params[:path]
    @page.page_translations_attributes = [ { :locale => params[:locale] } ] 
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = t('admin.successfully_created_page')
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @page.update_attributes(params[:page])
      flash[:notice] = t('admin.successfully_updated_page')
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page.destroy
    flash[:notice] = t('admin.successfully_destroyed_page')
    redirect_to pages_url
  end
  
  private
  def find_page
    @page = Page.find(params[:id])
  end
end
