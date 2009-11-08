class Cart
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def limit_exceed?
    @items.size >= 3
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
