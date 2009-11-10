class HousesController < ApplicationController
  before_filter :authorize, :except => [:index, :show, :cart, :empty_cart]

  def index
    tag = Taggable.find_by_field('category').tags.find_by_name(params[:category]) unless params[:category].blank?
    if tag
      search = tag.houses.searchlogic
    else
      if params[:discount]
	search = House.discounts.searchlogic
      else
        search = House.searchlogic
      end
    end
    search.persons_gte = params[:q][:persons].to_i unless params[:q].nil? or params[:q][:persons].blank?
    search.code_like = params[:q][:code] unless params[:q].nil? or params[:q][:code].blank?
    unless params[:q].nil? or params[:q][:where].blank? 
      city = Taggable.find_by_field('city_id').tags.find_by_name(params[:q][:where])
      search.city_id = city.id if city
    end
    if params[:advanced] == '1' and params[:q]
      house_type = Taggable.find_by_field('house_type_id').tags.find_by_name(params[:q][:type]) unless params[:q][:type].blank?
      search.house_type_id = house_type.id if house_type
      search.sat = params[:sat] unless params[:sat].blank? or params[:sat] != '1'
      search.clima_id = Taggable.find_by_field('clima_id').tags.select{|tag| tag.name(:locale => 'hu') != 'nincs' }.map{|tag| tag.id} unless params[:clima].blank? or params[:clima] != '1'
      search.internet = params[:internet] unless params[:internet].blank? or params[:internet] != '1'
      search.grill = params[:grill] unless params[:grill].blank? or params[:grill] != '1'
      search.pool = params[:pool] unless params[:pool].blank? or params[:pool] != '1'
      search.animals = params[:animals] unless params[:animals].blank? or params[:animals] != '1'
      parking = Taggable.find_by_field('parking_id').tags.find_by_name(params[:q][:parking]) unless params[:q][:parking].blank?
      search.parking_id = parking.id if parking
      search.distance_center_lte = params[:q][:distance_center].to_i unless params[:q][:distance_center].blank?
      search.distance_beach_lte = params[:q][:distance_beach].to_i unless params[:q][:distance_beach].blank?
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
    @empties = empties_helper
    if @house.save
      flash[:notice] = t "admin.house_added", :house => @house.code
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
      flash[:notice] = t "admin.house_updated", :house => @house.code
      redirect_to @house
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @house = House.find(params[:id]) 
    @house.destroy
    flash[:notice] = t "admin.house_deleted", :house => @house.code
    redirect_to houses_url
  end
  
  def cart
    @cart = find_cart
    begin
      house = House.find(params[:id]) if params[:id]
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid house #{params[:id]}")
      redirect_to_index("invalid_house")
    else
      if params[:cart] == 'add'
	if @cart.limit_exceed?
	  flash[:notice] = t :cart_limit
	else
	  @cart.add_house(house)
	  flash[:notice] = t "house_added_to_cart", :house => house.code
	end
      end
      if params[:cart] == 'del'
	@cart.remove_house(house)
	flash[:notice] = t "house_removed_from_cart", :house => house.code
      end
      @selected = House.find_all_by_id(@cart.items)
      if params[:cart]
	redirect_to :back
      end
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index("cart_is_empty")
  end

  private

  def redirect_to_index(msg)
    flash[:notice] = t(msg)
    redirect_to :action => :index
  end
end
