class HousesController < ApplicationController
#  before_filter :discounted, :only => [:new, :create, :edit, :update]
  def index
    tag = Taggable.find_by_field('category').tags.find_by_name(params[:category]) unless params[:category].blank?
    if tag
      search = tag.houses.searchlogic
    else
      search = House.searchlogic
    end
    search.city_id = params[:place].to_i unless params[:place].blank?
    search.persons_gte = params[:persons_gte].to_i unless  params[:persons_gte].blank?
    search.code_like = params[:q][:code_like] unless params[:q].nil? or params[:q][:code_like].blank?
    if params[:advanced] == '1'
      search.house_type_id = params[:type] unless params[:type].blank?
      search.sat = params[:sat] unless params[:sat].blank? or params[:sat] != '1'
      search.clima_id = Taggable.find_by_field('clima_id').tags.select{|tag| tag.name(:locale => 'hu') != 'nincs' }.map{|tag| tag.id} unless params[:clima].blank? or params[:clima] != '1'
      search.internet = params[:internet] unless params[:internet].blank? or params[:internet] != '1'
      search.grill = params[:grill] unless params[:grill].blank? or params[:grill] != '1'
      search.pool = params[:pool] unless params[:pool].blank? or params[:pool] != '1'
    end
    
    @houses, @houses_count = search.all(:select => "houses.id,code, city_id, persons, animals, pictures, house_type_id, condition_id, furnishing_id, floor_area, distance_center, distance_beach, distance_restaurant, distance_shop, distance_mainroad, distance_station").paginate(:page => params[:page], :per_page => 10), search.count
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
    begin
      house = House.find(params[:id]) if params[:id]
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid house #p{params[:id]}")
      redirect_to_index("Invalid house")
    else
      if params[:cart] == 'add'
	@cart.add_house(house)
	flash[:notice] = "House succesfully added to cart."
      end
      if params[:cart] == 'del'
	@cart.remove_house(house)
	flash[:notice] = "House successfully removed from cart."
      end
      @selected = House.find_all_by_id(@cart.items)
      if params[:cart]
	redirect_to :back
      end
    end
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
