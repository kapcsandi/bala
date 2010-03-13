class SeasonsController < ApplicationController
  before_filter :root_authorize
  before_filter :find_season, :except => [:index, :new, :create, :house_seasons ]

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
    @house_seasons = @season.house_seasons
  end
  
  def update
    if @season.update_attributes(params[:season])
      if params[:season][:house_seasons_attributes]
        params[:season][:house_seasons_attributes].each_pair do |k,v|
          @season.house_seasons.find(v['id']).destroy if v['_delete'] == '1'
        end
      end
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

  def house_seasons
    @seasons = Season.inactives_or_id_equals(HouseSeason.season_ids)
    @season_ids, @house_ids = [], []
    @season_ids = params[:house_seasons][:season_ids] if params[:house_seasons] and params[:house_seasons][:season_ids]
    @house_ids  = params[:house_seasons][:house_ids] if params[:house_seasons] and params[:house_seasons][:house_ids]
    @house_ids.each do |house_id|
      @season_ids.each do |season_id|
        exists = HouseSeason.find_by_house_id_and_season_id(house_id,season_id)
        unless exists
          HouseSeason.create(:house_id => house_id, :season_id => season_id)
        else
        end
      end
    end
  end
  
  private
  def find_season
    @season = Season.find(params[:id])
  end
end
