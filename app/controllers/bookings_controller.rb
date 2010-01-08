class BookingsController < ApplicationController
  before_filter :authorize, :except => [:new, :create, :sort, :calculate]
  before_filter :find_booking, :only => [:edit, :update, :destroy]
  before_filter :find_houses, :only => [:edit, :update]

  def index
  end


  def show
    begin
      @booking = Booking.find(params[:id])
    rescue
      flash[:error] = 'Nem létező foglalás'
      redirect_to root_path
    end
  end

  def new
    @booking = Booking.new
    @houses_bookings = @booking.houses_bookings.build
    if params[:id]
      @houses = House.find([ params[:id].to_i ])
    else
      cart = find_cart
      @houses = House.find(cart.items)
    end
    @codes = @houses.map{|house| house.code + ' ' + house.city}.to_sentence
    @booking_title = t('booking_title', :houses => @codes)
    @flash_warning = t('booking_warning')
  end

  def create
    @booking = Booking.new(params[:booking])
    booking_houses = params[:booking].delete(:houses)
    case booking_houses
    when Hash
      ids = booking_houses.keys
      houses_found = House.find_all_by_id(ids)
    when Array
      code = booking_houses[0][:code]
      houses_found = House.find_all_by_code(code)
    end
    @houses = houses_found
    unless houses_found.empty?
#      @booking.houses << houses_found
      hb = params[:booking].delete(:houses_booking)
      price = 0
      houses_found.each do |house|
        @houses_booking = house.houses_bookings.build
        @houses_booking.house_id = house.id
        @houses_booking.start_at = hb[:start_at]
        @houses_booking.end_at = hb[:end_at]
        price = if params[:house_0_price] then params[:house_0_price] else params["house_#{house.id}_price"] end
        @houses_booking.price = price
        @booking.houses_bookings << @houses_booking
      end
      @booking.price = price
      begin
        if @booking.save
          flash[:notice] = t("created_booking") unless admin?
          notification_mails(@booking)
          redirect_to @houses
        else
          render :action => 'new'
        end
      rescue ActiveRecord::RecordInvalid
        logger.info($!.to_s)
        render :action => 'new'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @houses_bookings = @booking.houses_bookings.first
  end

  def update
    @houses_bookings = @booking.houses_bookings
    houses = params["booking"].delete("houses") {|house| house.keys}
    params["booking"]["houses_bookings"] = houses.keys.map {|key| key.to_i}
    if @booking.update_attributes(params[:booking])
      flash[:notice] = t("updated_booking")
      redirect_to @booking
    else
      render :action => 'edit'
    end
  end

  def destroy
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
    houses = House.find_all_by_code(params[:codes].split(',').compact) unless params[:codes].empty?
    persons = params[:persons] unless params[:persons].empty?
    from = Date.parse(params[:from]) unless params[:from].empty?
    to = Date.parse(params[:to]) unless params[:to].empty?
    animals = params[:animals] unless params[:animals].empty?
    @prices = []
    if houses and !houses.empty? and from and to and to > from
      houses.each_with_index do |house,index|
        @prices[index] = 0
        season_price = 0
        days = 1
        adds = []
        prev_season = Season.which_season?(from)
        (from+1..to).step do |day|
          season = Season.which_season?(day)
    #      logger.info "_start_ days: #{days}, date: #{day}, season: #{season}"
          if season == prev_season
            adds << house.daily_price(season)
    #        logger.info "same season"
            if days % 7 == 0
  #            logger.info "7th day of season"
              7.times { adds.pop }
              adds << house.price(season)
              days = 0
            end
          else
  #         logger.info "new season"
            if (days % 7) != 0
  #           logger.info "prev season fragment week"
              season_price += days * house.daily_price(prev_season)
              adds << house.daily_price(season)
            else
  #           logger.info "prev season full week"
              season_price += house.price(prev_season)
              7.times { adds.pop }
              adds << house.price(prev_season)
              adds << house.daily_price(season)
            end
            days, season_price = 0, 0
            prev_season = season
          end
  #        logger.info "_end_ days: #{days}, date: #{day}, season: #{season}, adds: #{adds.inspect}"
          days += 1
        end
        adds.each {|elem| @prices[index] += elem }
      end
  #      logger.info  "_last_ day: #{days}, season: #{prev_season}, adds: #{adds.inspect}"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_houses
    @houses = @booking.houses
  end

  def redirect_to_index(msg)
    flash[:notice] = t(msg)
    redirect_to :controller => :houses, :advanced => 1
  end

  def notification_mails(booking)
    codes = {}
    booking.houses.each{|house| codes[house.id] = house.code}
    houses_bookings = booking.houses_bookings
    Notifications.deliver_booking(codes,booking, houses_bookings)
    Notifications.deliver_booking_admin(codes,booking, houses_bookings)
  rescue
    log_error($!)
  end
end
