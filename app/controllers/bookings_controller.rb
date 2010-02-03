class BookingsController < ApplicationController
  before_filter :authorize, :except => [:new, :create, :sort, :calculate]
  before_filter :find_booking, :only => [:edit, :update, :destroy]
  before_filter :find_houses, :only => [:edit, :update]

  def index
    redirect_to root_path
  end


  def show
    begin
      @booking = Booking.find(params[:id])
      @houses_booking = @booking.houses_bookings.first
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
      if admin?
        @houses = []
      else
        @houses = House.find(cart.items)
      end
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
      hb = params[:booking][:houses_booking]
      price = 0
      houses_found.each do |house|
        @houses_booking = house.houses_bookings.build
        @houses_booking.house_id = house.id
        @houses_booking.start_at = hb[:start_at] unless hb[:start_at].empty?
        @houses_booking.end_at = hb[:end_at] unless hb[:end_at].empty?
        price = if params[:house_0_price] then params["house_#{houses_found.index(house)}_price"] else params["house_#{house.id}_price"] end
        @houses_booking.price = price
        current_user.houses_bookings << @houses_booking if admin?
        @booking.houses_bookings << @houses_booking
      end
      @booking.price = price
      begin
        if @booking.save
          if admin?
            flash[:notice] = t("admin.successfully_created_booking")
          else
            flash[:notice] = t("created_booking")
          end
          notification_mails(@booking)
          redirect_to houses_path
        else
          render :action => 'new'
        end
      rescue ActiveRecord::RecordInvalid
        logger.info($!.to_s)
        render :action => 'new'
      end
    else
      @houses_booking = @booking.houses_bookings.build
      render :action => 'new'
    end
  end

  def edit
    @houses_bookings = @booking.houses_bookings
  end

  def update
    @houses_bookings = @booking.houses_bookings
    houses = params["booking"].delete("houses") {|house| house.keys}
    @houses_bookings.each do |hb|
      logger.info params[:booking][:houses_bookings][hb.house_id.to_s].inspect
      hb.price = params[:booking][:houses_bookings][hb.house_id.to_s][:price]
      hb.start_at = params[:booking][:houses_booking][:start_at]
      hb.end_at = params[:booking][:houses_booking][:end_at]
      hb.status = params[:booking][:status]
      current_user.houses_bookings << hb unless hb.owner
      hb.save
    end
    params["booking"].delete("houses_bookings")
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
    redirect_to houses_bookings_path
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
          if season == prev_season
            adds << house.daily_price(season)
            if days % 7 == 0
              7.times { adds.pop }
              adds << house.price(season)
              days = 0
            end
          else
            if (days % 7) != 0
              season_price += days * house.daily_price(prev_season)
              adds << house.daily_price(season)
            else
              season_price += house.price(prev_season)
              7.times { adds.pop }
              adds << house.price(prev_season)
              adds << house.daily_price(season)
            end
            days, season_price = 0, 0
            prev_season = season
          end
          days += 1
        end
        adds.each {|elem| @prices[index] += elem }
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def test
    @booking = Booking.find(params[:id])
    notification_mails(@booking)
    redirect_to_index($!)
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
    booking.houses.each{|house| codes[house.id] = house.name }
    houses_bookings = booking.houses_bookings
    Notifications.deliver_booking(codes,booking, houses_bookings) unless admin?
    Notifications.deliver_booking_admin(codes,booking, houses_bookings)
  rescue
    log_error($!)
  end
end
