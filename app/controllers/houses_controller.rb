class HousesController < ApplicationController
#  before_filter :discounted, :only => [:new, :create, :edit, :update]
  def index
    search = House.search #(params[:search])
#    search.persons_lte = params[:search][:persons_lte] if params[:search] and params[:search][:persons_lte]
    search.city_id = params[:city] unless params[:city].blank?
    search.persons_gte = params[:search][:persons_gte] unless params[:search][:persons_gte].blank?
    search.code_like = params[:search][:code_like] unless params[:search][:code_like].blank?
    @houses = search.all    
  end
  
  def show
    @house = House.find(params[:id])
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
  
private

end
