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
    @houses = House.find(cart.items)
  end
  
  def create
    @booking = Booking.new(params[:booking])
    cart = find_cart
    @houses = House.find(cart.items)
    @booking.houses << @houses
    if @booking.save
      flash[:notice] = "Successfully created booking."
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
      flash[:notice] = "Successfully updated booking."
      redirect_to @booking
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "Successfully destroyed booking."
    redirect_to bookings_url
  end

private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
