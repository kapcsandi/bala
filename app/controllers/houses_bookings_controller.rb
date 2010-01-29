class HousesBookingsController < ApplicationController
  before_filter :authorize
  before_filter :find_houses_booking, :except => [:index, :new, :create]
  before_filter :find_house, :only => [:edit, :update]

  def index
    @search = House.searchlogic(params[:search])
    @year = params[:date] && params[:date][:year] || Date.today.year
    @month = params[:date] && params[:date][:month] || Date.today.month
    @all = params[:all]
    @year, @month = @year.to_i, @month.to_i
    @date = Date.parse("#{@year}-#{@month}-01")
    @house = @search.first
    if @all
      if @house and params[:search] and not params[:search][:code].empty? then
        @bookings = @house.houses_bookings.paginate(:page => params[:page], :per_page => 10)
      else
        @bookings = HousesBooking.all.paginate(:page => params[:page], :per_page => 10)
      end
    else
      @shown_month = Date.civil(@year, @month)
      @first_day_of_week = 1
      if @house and params[:search] and not params[:search][:code].empty? then

#         @events = Event.events_for_date_range(start_d, end_d)
#         @event_strips = Event.create_event_strips(start_d, end_d, @events)


        @hbookings = @house.houses_bookings         #        .on_month(@shown_month).with_assoc
        start_d, end_d = @hbookings.get_start_and_end_dates(@shown_month,@first_day_of_week) # optionally pass in @first_day_of_week
        @bookings = @hbookings.events_for_date_range(start_d, end_d)
#        @event_strips = @bookings.event_strips_for_month(@shown_month,@first_day_of_week)
        @event_strips = @hbookings.create_event_strips(start_d, end_d, @bookings)
      else
        @bookings = HousesBooking.on_month(@shown_month).with_assoc
        @event_strips = HousesBooking.event_strips_for_month(@shown_month,@first_day_of_week)
      end
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
      flash[:notice] = t("admin.successfully_created_houses_booking")
      event_logger("#{current_user.username} foglaltságot rögzített: <a href=\"/houses_bookings/#{@houses_booking.id}\">#{@houses_booking.code}</a>,, #{@houses_booking.start_at} - #{@houses_booking.end_at}")
      redirect_to @houses_booking
    else
      @house ||= House.new
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    current_user.houses_bookings << @houses_booking unless @houses_booking.owner
    if @houses_booking.update_attributes(params[:houses_booking])
      flash[:notice] = t("updated_booking")
      event_logger("#{current_user.username} foglaltságot módosított: <a href=\"/houses_bookings/#{@houses_booking.id}\">#{@houses_booking.code}</a>, #{@houses_booking.start_at} - #{@houses_booking.end_at}")
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
