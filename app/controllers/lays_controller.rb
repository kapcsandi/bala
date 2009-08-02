class LaysController < ApplicationController
  def index
    @lays = Lay.all
  end
  
  def show
    @lay = Lay.find(params[:id])
  end
  
  def new
    @lay = Lay.new
  end
  
  def create
    @lay = Lay.new(params[:lay])
    if @lay.save
      flash[:notice] = "Successfully created lay."
      redirect_to @lay
    else
      render :action => 'new'
    end
  end
  
  def edit
    @lay = Lay.find(params[:id])
  end
  
  def update
    @lay = Lay.find(params[:id])
    if @lay.update_attributes(params[:lay])
      flash[:notice] = "Successfully updated lay."
      redirect_to @lay
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @lay = Lay.find(params[:id])
    @lay.destroy
    flash[:notice] = "Successfully destroyed lay."
    redirect_to lays_url
  end
end
