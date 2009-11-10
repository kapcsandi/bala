class PagesController < ApplicationController
  before_filter :authorize, :except => [:show]
  
  def index
    @pages = Page.all
  end
  
  def show
    if params[:id].to_s.to_i == 0
      page = params[:id]
    else
      id = params[:id]
    end
    if page
      @page = Page.find_by_path(page.to_s)
    elsif id
      @page = Page.find(id)
    end
    if @page.nil?
      if admin?
        redirect_to new_page_path(:path => page)
      else
        redirect_to root_url
      end
    elsif not @page.published?
      redirect_to edit_page_path(@page)
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
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = t('admin.successfully_updated_page')
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = t('admin.successfully_destroyed_page')
    redirect_to pages_url
  end
end
