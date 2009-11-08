class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @year = Date.today.year.to_i
    @month = Date.today.month.to_i
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def new
    @booking = Booking.new
    @booking.houses.build
    cart = find_cart
    redirect_to_index(:select_houses) if cart.items.size < 1
    @houses = House.find(cart.items)
  end
  
  def create
    @booking = Booking.new(params[:booking])
    cart = find_cart
    @houses = House.find(cart.items)
    if session[:order]
      session[:order].each_with_index do |id, index|
        logger.info "@houses_bookings values: #{id}"
        @booking.houses_bookings.build(:house_id => id, :position => index)
      end
    else
      @booking.houses << @houses
    end
    if @booking.save
      flash[:notice] = t "created_booking"
      notification_mails(@booking)
      redirect_to @booking
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
