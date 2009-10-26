class Cart
  attr_reader :items
  
  class Item 
    attr_accessor :elem, :position
    
    def initialize
      elem, position = nil, 0
    end
    
#    acts_as_list
  end
  
  def initialize
    @items = []
  end
  
  def add_house(house)
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
#      flash[:notice] ="Anyad!"
      return
    end
    if current_item
#      flash[:notice] = "Már a kosárban van."
    else
      @items << house.id
    end
  end
  def remove_house(house)
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
#      flash[:notice] ="Anyad!"
      return
    end
    if current_item
      @items.delete(house.id)
    else
#      flash[:notice] = "Nincs a kosárban. Ejnye!"
    end
  end
end
