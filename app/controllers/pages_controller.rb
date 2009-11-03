class PagesController < ApplicationController
  
  def index
    @pages = Page.all
  end
  
  def show
    #  sights, :offers, :terms, :impressum, :owners, :admin_login]
    page = params[:page]
    id = params[:id]
    if page
      @page = Page.find_by_path(page.to_s)
    elsif id
      @page = Page.find(id)
    end
    redirect_to(new_page_path, :path => page)if @page.nil?
  end
  
  def new
    @page = Page.new
    @page.page_translations_attributes = [ { :locale => params[:locale] } ] 
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
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
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
end
