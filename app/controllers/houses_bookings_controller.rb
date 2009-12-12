class HousesBookingsController < ApplicationController
  before_filter :authorize
  
  def index
    @houses_bookings = HousesBooking.all(:include => [:booking, :house])
  end
  
  def show
    @houses_booking = HousesBooking.find(params[:id])
  end
  
  def new
    @houses_booking = HousesBooking.new
    @house = @houses_booking.build_house
  end
  
  def create
    @houses_booking = HousesBooking.new(params[:houses_booking])
    @house = @houses_booking.build_house
    if @houses_booking.save
      flash[:notice] = t("created_booking")
      redirect_to @houses_booking
    else
      render :action => 'new'
    end
  end
  
  def edit
    @houses_booking = HousesBooking.find(params[:id])
    @house = @houses_booking.house
  end
  
  def update
    @houses_booking = HousesBooking.find(params[:id])
    @house = @houses_booking.house
    if @houses_booking.update_attributes(params[:houses_booking])
      flash[:notice] = t("updated_booking")
      redirect_to @houses_booking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @houses_booking = HousesBooking.find(params[:id])
    @houses_booking.destroy
    flash[:notice] = t "destroyed_booking"
    redirect_to houses_bookings_url
  end
end
