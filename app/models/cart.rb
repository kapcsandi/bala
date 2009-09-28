class Cart
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_remove_house(house)
    begin
    current_item = @items.find {|item|item == house}
    rescue
      flash[:notice] ="Anyad!"
      return
    end
    if current_item
      @items.delete(house)
    else
      @items << house
    end
  end
end
