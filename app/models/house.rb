class House < ActiveRecord::Base
  translates :house_description

  has_one :discount, :dependent => :destroy
  has_many :houses_taggables
  has_many :taggables, :through => :houses_taggables, :order => :position
  has_many :houses_tags
  has_many :tags, :through => :houses_tags, :uniq => true
  has_many :houses_bookings
  has_many :bookings, :through => :houses_bookings, :uniq => true

  accepts_nested_attributes_for :discount, :allow_destroy => true
  accepts_nested_attributes_for :tags, :allow_destroy => true
  
  validates_presence_of :code, :city_id, :house_type_id, :condition_id, :furnishing_id
  validates_uniqueness_of :code
  
  named_scope :discounts, {:joins => :discount}
  named_scope :scroll_pictures, lambda { |tag|
    {:joins => :houses_tags,
    :conditions => { :houses_tags => {:tag_id => tag }},
    :select => "houses.id,code,pictures,persons,children"}
                                       }
#   named_scope :prices, lambda {|code| {:conditions => {:code => code}, :limit => 1,
#                                :select => "price_pre_season_per_week,price_pre_season_per_day,
#                               price_mid_season_per_week,price_mid_season_per_day,
#                               price_main_season_per_week,price_main_season_per_day
#                               "}}
  def discounted?
    if self.discount.nil? or self.discount.new_record? or self.discount == 0
      false
    else
      true
    end
  end
  
  def pool?
    if self.pool.nil? or self.new_record? or self.pool == 0
      false
    else
      true
    end
  end
  
  def animals?
    if self.animals.nil? or self.new_record? or self.animals == 0
      false
    else
      true
    end
  end
  
  def city
    Tag.find(city_id).name
  end

  def house_type
    Tag.find(house_type_id).name
  end

  def condition
    Tag.find(condition_id).name
  end

  def furnishing
    Tag.find(furnishing_id).name
  end

  def terrace
    Tag.find(terrace_id).name unless terrace_id.nil?
  end

  def stove
    Tag.find(stove_id).name unless stove_id.nil?
  end

  def clima
    Tag.find(clima_id).name unless clima_id.nil?
  end

  def parking
    Tag.find(parking_id).name unless parking_id.nil?
  end

  def owner_place
    Tag.find(owner_place_id).name unless owner_place_id.nil?
  end

  def stripped_code
    self.code.sub(/-\d+$/,'')
  end
  
  def picture_urls(size)
    pictures.split(',').map{|id| id.sub(/-([0-9]+)$/,'_\1')}.map{|pid| APP_CONFIG['asset_server']+self.stripped_code+'/'+pid+"_#{size}.jpg" if pid !~ /\ |$^/ }.compact if pictures
  end

  def thumb
    id = pictures.split(',').select{|id| id =~ /[0-9\-_]+/}[0]
    APP_CONFIG['asset_server']+self.stripped_code+'/'+id+'_s.jpg' if id
  end
  
  def picture_ids
    pictures.split(',').map{|id| id.sub(/-([0-9]+)$/,'_\1')} if pictures
  end

  def picture_ids=(ids)
    self.pictures = ids.join(',')
  end
  
  def self.per_page
    10
  end

  def price(name)
    case name
    when /pre|post/
    self.price_pre_season_per_week
    when /mid/
    self.price_mid_season_per_week
    when /main/
    self.price_main_season_per_week
    end
  end
  def daily_price(name)
    case name
    when /pre|post/
    self.price_pre_season_per_day
    when /mid/
    self.price_mid_season_per_day
    when /main/
    self.price_main_season_per_day
    end
  end

  def distance(item)
    self.method("distance_#{item}").call
  end
end

# script/generate model reservation house_id:integer from:date to:date persons:integer user_id:integer status:integer comment:text
