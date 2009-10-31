class Cart
  attr_reader :items
  
  class Item 
    attr_accessor :elem, :position
    
    def initialize
      elem, position = nil, 0
    end
  end
  
  def initialize
    @items = []
  end
  
  def limit_exceed?
    @items.count == 3
  end
  
  def add_house(house)
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
      return
    end
    @items << house.id unless current_item
  end
  def remove_house(house)
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
      return
    end
    if current_item
      @items.delete(house.id)
    end
  end
end
