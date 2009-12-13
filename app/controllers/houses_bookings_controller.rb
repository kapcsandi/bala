class HousesBookingsController < ApplicationController
  before_filter :authorize
  
  def index
#     @houses_bookings = HousesBooking.all(:include => [:booking, :house])
    @search = House.searchlogic(params[:search])
    @year = params[:year] || Date.today.year
    @month = params[:month] || Date.today.month
    @year, @month = @year.to_i, @month.to_i
    @date = Date.parse("#{@year}-#{@month}-01")
    @house = @search.first
    if @house then
      logger.info "house: #{@house.code}"
      @bookings = @house.houses_bookings(:include => [:booking, :house])
    else
      logger.info "ALL"
      @bookings = HousesBooking.all(:include => [:booking, :house])
    end

    @shown_month = Date.civil(@year, @month)
    @event_strips = @bookings.event_strips_for_month(@shown_month) if @house

    
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
    @house = House.find_by_code(params[:houses_booking][:houses].first[:code])
    @houses_booking.house_id = @house.id
    @houses_booking.owner_id = @current_user.id
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
