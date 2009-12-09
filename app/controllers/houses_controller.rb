class HousesController < ApplicationController
  before_filter :authorize, :except => [:index, :show, :print, :cart, :empty_cart]
  before_filter :search_house, :except => [:index, :new, :create, :cart, :empty_cart]
  before_filter :get_cart, :only => [:index, :cart, :empty_cart, :print, :show]

  def index
    if request.xhr? and params[:autocomplete]
      search = House.searchlogic(params[:search])
      @houses = search.all
      logger.info "#{Time.now} @houses = #{@houses.inspect}"
      if @houses.size == 1
        respond_to do |format|
          format.js
        end
      else
        render :inline => "<%= auto_complete_result @houses, :code %>"
      end
    else
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
  #    search.persons_gte = params[:q][:persons].to_i unless params[:q].nil? or params[:q][:persons].blank?
  #    search.persons_inda_house_gte = params[:q][:persons].to_i unless params[:q].nil? or params[:q][:persons].blank?
      search.code_like = params[:q][:code] unless params[:q].nil? or params[:q][:code].blank?
      unless params[:q].nil? or params[:q][:where].blank?
        city = Taggable.find_by_field('city_id').tags.find_by_name(params[:q][:where])
        search.city_id = city.id if city
      end
      if params[:advanced] and params[:q]
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
    end
  end

  def show
  end

  def print
    render "show", :layout => 'print'
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
    @house.taggables.build
    @house.tags.build
    if @house.discounted?
      @discount = @house.discount
    else
      @discount = @house.build_discount
    end
  end
  
  def update
    if @house.update_attributes(params[:house])
      @house.discount.destroy unless params[:discounted]
      flash[:notice] = t "admin.house_updated", :house => @house.code
      redirect_to @house
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @house.destroy
    flash[:notice] = t "admin.house_deleted", :house => @house.code
    redirect_to houses_url
  end
  
  def cart
    begin
      house = House.find(params[:id]) if params[:id]
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid house #{params[:id]}")
      redirect_to_index("invalid_house")
    else
      if params[:cart] == 'add'
    if @cart.limit_exceed?
      flash[:error] = t :cart_limit
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
	redirect_to :back, :anchor => "house_#{params[:id]}"
      end
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index("cart_is_empty")
  end

  private

  def search_house
    @house = House.find(params[:id])
  end

  def get_cart
    @cart = find_cart
  end

  def redirect_to_index(msg)
    flash[:notice] = t(msg)
    redirect_to :action => :index
  end
end
