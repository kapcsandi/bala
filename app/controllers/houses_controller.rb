class HousesController < ApplicationController
  def index
    @houses = House.all
  end
  
  def show
    @house = House.find(params[:id])
  end
  
  def new
    @house = House.new
  end
  
  def create
    @house = House.new(params[:house])
    if @house.save
      flash[:notice] = "Successfully created house."
      redirect_to @house
    else
      render :action => 'new'
    end
  end
  
  def edit
    @house = House.find(params[:id])
  end
  
  def update
    @house = House.find(params[:id])
    if @house.update_attributes(params[:house])
      flash[:notice] = "Successfully updated house."
      redirect_to @house
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @house = House.find(params[:id])
    @house.destroy
    flash[:notice] = "Successfully destroyed house."
    redirect_to houses_url
  end
end
