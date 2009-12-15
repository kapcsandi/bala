class HousesBookingsController < ApplicationController
  before_filter :authorize
  before_filter :find_houses_booking, :except => [:index, :new, :create]
  before_filter :find_house, :only => [:edit, :update]

  def index
#     @houses_bookings = HousesBooking.all(:include => [:booking, :house])
    @search = House.searchlogic(params[:search])
    @year = params[:date] && params[:date][:year] || Date.today.year
    @month = params[:date] && params[:date][:month] || Date.today.month
    @year, @month = @year.to_i, @month.to_i
    @date = Date.parse("#{@year}-#{@month}-01")
    @house = @search.first
    @shown_month = Date.civil(@year, @month)
    @first_day_of_week = 1
    if @house and not params[:search][:code].empty? then
#       logger.info "house: #{@house.code}"
      @bookings = @house.houses_bookings.on_month(@shown_month).with_assoc
      @event_strips = @bookings.event_strips_for_month(@shown_month,@first_day_of_week)
    else
#       logger.info "ALL"
      @bookings = HousesBooking.on_month(@shown_month).with_assoc
      @event_strips = HousesBooking.event_strips_for_month(@shown_month,@first_day_of_week)
    end
  end
  
  def show
  end
  
  def new
    @houses_booking = HousesBooking.new
    @house = @houses_booking.build_house
  end
  
  def create
    @houses_booking = current_user.houses_bookings.build(params[:houses_booking])
    @house = House.find_by_code(params[:houses_booking][:houses].first[:code])
    if @house
      @house.houses_bookings << @houses_booking
    end
    if @house and @houses_booking.save
      flash[:notice] = t("created_booking")
      event_logger("#{current_user.username} foglaltságot rögzített: #{@house.code}, #{@houses_booking.start_at} - #{@houses_booking.end_at}")
      redirect_to @houses_booking
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    current_user.houses_bookings << @houses_booking unless @houses_booking.owner
    if @houses_booking.update_attributes(params[:houses_booking])
      flash[:notice] = t("updated_booking")
      event_logger("#{current_user.username} foglaltságot módosított: #{@house.code}, #{@houses_booking.start_at} - #{@houses_booking.end_at}")
      redirect_to @houses_booking
    else
      render :action => 'edit'
    end
  end

  def destroy
    event_logger("#{current_user.username} foglaltságot törölt: #{@houses_booking.house.code}, #{@houses_booking.start_at} - #{@houses_booking.end_at}")
    @houses_booking.destroy
    flash[:notice] = t "destroyed_booking"
    redirect_to houses_bookings_url
  end

  private
  def find_houses_booking
    begin
      @houses_booking = HousesBooking.find(params[:id])
    rescue
      redirect_to root_path
    end
  end

  def find_house
    @house = @houses_booking.house
  end
end
