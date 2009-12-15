class SeasonsController < ApplicationController
  before_filter :authorize
  before_filter :find_season, :except => [:index, :new, :create]
  
  def index
    @seasons = Season.all
  end
  
  def show
  end
  
  def new
    @season = Season.new
  end
  
  def create
    @season = Season.new(params[:season])
    if @season.save
      flash[:notice] = t('admin.successfully_created_season')
      redirect_to @season
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @season.update_attributes(params[:season])
      flash[:notice] = t('admin.successfully_updated_season')
      redirect_to @season
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @season.destroy
    flash[:notice] = t('admin.successfully_destroyed_season')
    redirect_to seasons_url
  end
  
  private
  def find_season
    @season = Season.find(params[:id])
  end
end
