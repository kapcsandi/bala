class HouseTypesController < ApplicationController
  def index
    @house_types = HouseType.all
  end
  
  def show
    @house_type = HouseType.find(params[:id])
  end
  
  def new
    @house_type = HouseType.new
  end
  
  def create
    @house_type = HouseType.new(params[:house_type])
    if @house_type.save
      flash[:notice] = "Successfully created house type."
      redirect_to @house_type
    else
      render :action => 'new'
    end
  end
  
  def edit
    @house_type = HouseType.find(params[:id])
  end
  
  def update
    @house_type = HouseType.find(params[:id])
    if @house_type.update_attributes(params[:house_type])
      flash[:notice] = "Successfully updated house type."
      redirect_to @house_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @house_type = HouseType.find(params[:id])
    @house_type.destroy
    flash[:notice] = "Successfully destroyed house type."
    redirect_to house_types_url
  end
end
