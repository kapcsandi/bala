class FurnishingsController < ApplicationController
  def index
    @furnishings = Furnishing.all
  end
  
  def show
    @furnishing = Furnishing.find(params[:id])
  end
  
  def new
    @furnishing = Furnishing.new
  end
  
  def create
    @furnishing = Furnishing.new(params[:furnishing])
    if @furnishing.save
      flash[:notice] = "Successfully created furnishing."
      redirect_to @furnishing
    else
      render :action => 'new'
    end
  end
  
  def edit
    @furnishing = Furnishing.find(params[:id])
  end
  
  def update
    @furnishing = Furnishing.find(params[:id])
    if @furnishing.update_attributes(params[:furnishing])
      flash[:notice] = "Successfully updated furnishing."
      redirect_to @furnishing
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @furnishing = Furnishing.find(params[:id])
    @furnishing.destroy
    flash[:notice] = "Successfully destroyed furnishing."
    redirect_to furnishings_url
  end
end
