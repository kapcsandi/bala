class HousesController < ApplicationController
#  before_filter :discounted, :only => [:new, :create, :edit, :update]
  def index
    tag = Taggable.find_by_field('category').tags.find_by_name(params[:category]) unless params[:category].blank?
    if tag
      search = tag.houses.search
    else
      search = House.search
    end
    search.city_id = params[:place].to_i unless params[:place].blank?
    search.persons_gte = params[:persons_gte].to_i unless  params[:persons_gte].blank?
    search.code_like = params[:q][:code_like] unless params[:q].nil? or params[:q][:code_like].blank?
    @houses = search.all(:select => "id,code, city_id, persons, animals, pictures, house_type_id, condition_id, furnishing_id, floor_area, distance_center, distance_beach, distance_restaurant, distance_shop, distance_mainroad, distance_station", :limit => 10)
    @cart = find_cart
  end
  
  def show
    @house = House.find(params[:id])
    @cart = find_cart
  end
  
  def new
    @house = House.new
    @discount = @house.build_discount
    @house.taggables.build
    @house.tags.build
    @empties = empties_helper
  end
  
  def create
    @house = House.new(params[:house])
    if @house.save
      flash[:notice] = t "Successfully created house."
      redirect_to @house
    else
      render :action => 'new'
    end
  end
  
  def edit
    @house = House.find(params[:id])
    @house.taggables.build
    @house.tags.build
    if @house.discounted?
      @discount = @house.discount
    else
      @discount = @house.build_discount
    end
  end
  
  def update
    @house = House.find(params[:id])
    if @house.update_attributes(params[:house])
      @house.discount.destroy unless params[:discounted]
      flash[:notice] = t "Successfully updated house."
      redirect_to @house
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @house = House.find(params[:id]) 
    @house.destroy
    flash[:notice] = t "Successfully destroyed house."
    redirect_to houses_url
  end
  
  def cart
    @cart = find_cart
    house = House.find(params[:id]) if params[:id].to_i > 0
    @cart.add_house(house) if house and params[:cart] == 'add'
    @cart.remove_house(house) if house and params[:cart] == 'del'
    @selected = House.find_all_by_id(@cart.items)
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index("Your cart is currently empty.")
  end
  
  def booking
    @cart = find_cart
    @selected = House.find_all_by_id(@cart.items)
  end
  
  def special
    redirect_to_index("Not implemented yet.")
  end
  
  private

  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end
end
