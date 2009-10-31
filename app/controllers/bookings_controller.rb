class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  
  def show
    @booking = Booking.find(params[:id])
  end
  
  def new
    @booking = Booking.new
    @booking.houses.build
    cart = find_cart
    redirect_to_index(:select_houses) if cart.items.count < 1
    @houses = House.find(cart.items)
  end
  
  def create
    @booking = Booking.new(params[:booking])
    cart = find_cart
    @houses = House.find(cart.items)
    @booking.houses << @houses
    if @booking.save
      flash[:notice] = t "created_booking"
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
  
  private
  
  def redirect_to_index(msg)
    flash[:notice] = t(msg)
    redirect_to :controller => :houses, :advanced => 1
  end
end
