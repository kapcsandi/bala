class House < ActiveRecord::Base
  translates :house_description

  has_one :discount, :dependent => :destroy
  has_many :houses_taggables
  has_many :taggables, :through => :houses_taggables, :order => :position
  has_many :houses_tags
  has_many :tags, :through => :houses_tags

  accepts_nested_attributes_for :discount, :allow_destroy => true
  accepts_nested_attributes_for :tags, :allow_destroy => true
  
  validates_presence_of :city_id, :house_type_id, :condition_id, :furnishing_id
  
  def discounted?
    if self.discount.nil? or self.discount.new_record? or self.discount == 0
      false
    else
      true
    end
  end
  
  def pool?
    if self.pool.nil? or self.pool.new_record? or self.pool == 0
      false
    else
      true
    end
  end
  
  def animals?
    if self.animals.nil? or self.animals.new_record? or self.animals == 0
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

  private
  def tagnames_by_position(position)
    Taggable.find_by_position(position).select{|tag| self.tags.include?(tag) }.map{|tag| tag.name}.join(', ')
  end

#   
#   def client_name
#     client.name if client
#   end
# 
#   def client_name=(name)
#     return nil if name.blank?
#     self.client = Client.find_or_create_by_name_and_agency( name,  0)
#   end
end
