class BookingsController < ApplicationController
  before_filter :authorize, :except => [:new, :create, :sort, :calculate]

  def index
  end


  def show
    begin
      @booking = Booking.find(params[:id])
    rescue
      flash[:warning] = 'Nem létező foglalás'
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
    unless houses_found.empty?
      @booking.houses << houses_found
      @houses = @booking.houses
      @houses_booking = @booking.houses_bookings.build
      @houses_booking.house_id = @houses.first.id
      houses_booking = params[:booking].delete(:houses_bookings)
      case houses_booking
      when Hash
        ids = houses_booking.keys
        hb = houses_booking[ids.first]
       when Array
        hb = houses_booking.first
      end
      @houses_booking.start_at = hb[:start_at]
      @houses_booking.end_at = hb[:end_at]
#       debugger
#       @houses_booking.save_with_dirty!
    begin
      if @booking.save
        @booking.houses_bookings.last.destroy
        logger.info "SAVED HB"
        if session[:order]
          session[:order].each_with_index do |id, index|
            logger.info "@houses_bookings values: #{id}"
            hb = hbs.find_by_house_id(id)
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
        @houses_bookings = @booking.houses_bookings.first
        render :action => 'new'
      end
  rescue ActiveRecord::RecordInvalid
    logger.info($!.to_s)
    render :action => 'new'
  end
    else
      @houses ||= []
      @houses_bookings = @booking.houses_bookings.first
      render :action => 'new'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @houses = @booking.houses
    @houses_bookings = @booking.houses_bookings.first
  end

  def update
    @booking = Booking.find(params[:id])
    @houses = @booking.houses
    @houses_bookings = @booking.houses_bookings
    if session[:order]
      logger.info "session:order exists"
      session[:order].each_with_index do |id, index|
        @booking.houses_bookings.update_all(['position=?',index+1],['house_id=?',id])
      end
    else
      logger.info "session:order NOT exists"
    end
    houses = params["booking"].delete("houses") {|house| house.keys}
    params["booking"]["houses_bookings"] = houses.keys.map {|key| key.to_i}
    debugger
    if @booking.update_attributes(params[:booking])
      flash[:notice] = t("updated_booking")
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
      @price, season_price = 0, 0
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
            logger.info "7th day of season"
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
      adds.each {|elem| @price += elem }
#      logger.info  "_last_ day: #{days}, season: #{prev_season}, adds: #{adds.inspect}"
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
    houses_booking = booking.houses_bookings.first
    Notifications.deliver_booking(house_codes,booking, houses_booking)
    Notifications.deliver_booking_admin(house_codes,booking, houses_booking)
  end
end
