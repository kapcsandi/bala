class RoomTypesController < ApplicationController
  def index
    @room_types = RoomType.all
  end
  
  def show
    @room_type = RoomType.find(params[:id])
  end
  
  def new
    @room_type = RoomType.new
  end
  
  def create
    @room_type = RoomType.new(params[:room_type])
    if @room_type.save
      flash[:notice] = "Successfully created room type."
      redirect_to @room_type
    else
      render :action => 'new'
    end
  end
  
  def edit
    @room_type = RoomType.find(params[:id])
  end
  
  def update
    @room_type = RoomType.find(params[:id])
    if @room_type.update_attributes(params[:room_type])
      flash[:notice] = "Successfully updated room type."
      redirect_to @room_type
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @room_type = RoomType.find(params[:id])
    @room_type.destroy
    flash[:notice] = "Successfully destroyed room type."
    redirect_to room_types_url
  end
end
