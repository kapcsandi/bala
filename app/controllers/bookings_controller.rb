class BookingsController < ApplicationController
  before_filter :authorize, :except => [:new, :create, :sort, :calculate]

  def index
    @search = House.searchlogic(params[:search])
    @year = params[:year] || Date.today.year
    @month = params[:month] || Date.today.month
    @year, @month = @year.to_i, @month.to_i
    @date = Date.parse("#{@year}-#{@month}-01")
    house = @search.first
    if house then
      @bookings = house.bookings
    else
      @bookings = Booking.all
    end

    @shown_month = Date.civil(@year, @month)
    @event_strips = @bookings.event_strips_for_month(@shown_month)
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def new
    @booking = Booking.new
#    @booking.houses_bookings.build
    @booking.houses.build
    if params[:id]
      @houses = House.find([ params[:id].to_i ])
    else
      cart = find_cart
#      redirect_to_index(:select_houses) if cart.items.size < 1
      @houses = House.find(cart.items)
    end
    @codes = @houses.map{|house| house.code + ' ' + house.city}.to_sentence
    @booking_title = t('booking_title', :houses => @codes)
    @flash_warning = t('booking_warning')
  end
  
  def create
    @booking = Booking.new(params[:booking])
    booking_houses = params[:booking][:houses]
    case booking_houses
    when Hash
      ids = params[:booking][:houses].keys
      houses_found = House.find_all_by_id(ids)
    when Array
      code = params[:booking][:houses][0][:code]
      houses_found = House.find_all_by_code(code)
    end
    if houses_found
      @booking.houses << houses_found
    else
#      error
    end
    @houses = @booking.houses
    if @booking.save
      if session[:order]
        session[:order].each_with_index do |id, index|
          logger.info "@houses_bookings values: #{id}"
          hb = @booking.houses_bookings.find_by_house_id(id)
          if hb
            hb.position = index
            hb.save
          end
        end
      end
      session[:order] = nil
      flash[:notice] = t("created_booking")
      notification_mails(@booking)
      redirect_to @houses
    else
      render :action => 'new'
    end
  end
  
  def edit
    @booking = Booking.find(params[:id])
    @houses = @booking.houses
  end
  
  def update
    @booking = Booking.find(params[:id])
    if session[:order]
      logger.info "session:order exists"
      session[:order].each_with_index do |id, index|
        @booking.houses_bookings.update_all(['position=?',index+1],['house_id=?',id])
      end
    else
      logger.info "session:order NOT exists"
    end
    if @booking.update_attributes(params[:booking])
      flash[:notice] = t "updated_booking"
      redirect_to @booking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = t "destroyed_booking"
    redirect_to bookings_url
  end
     
  def sort
    @houses_bookings = {}
    logger.info "@houses_bookings exists"
    session[:order] = params[:houses_bookings]
    render :nothing => true
  end

  def calculate
    house = House.find_by_code(params[:codes].split(',')[0]) unless params[:codes].empty?
    persons = params[:persons] unless params[:persons].empty?
    from = Date.parse(params[:from]) unless params[:from].empty?
    to = Date.parse(params[:to]) unless params[:to].empty?
    animals = params[:animals] unless params[:animals].empty?
    if house and persons and from and to and to > from
      days = to - from
      @price, animal_charge = 0,  animals && animals == 'true' && house.animal_charge > 0 ? house.animal_charge : 0
      week_counter = 0
      season_counter = 0
      (from..to-1).step do |day|
        logger.info "#{Time.now} #{day}"
        season = Season.which_season?(day)
        logger.info "#{Time.now} #{season}"
        price = house.daily_price(season)
        logger.info "#{Time.now} #{price}"
        @price += price
      end
    else
      @price = ""
    end
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def redirect_to_index(msg)
    flash[:notice] = t(msg)
    redirect_to :controller => :houses, :advanced => 1
  end

  def notification_mails(booking)
    house_codes = booking.houses.map{|house| house.code}
    Notifications.deliver_booking(house_codes,booking)
    Notifications.deliver_booking_admin(house_codes,booking)
  end
end
