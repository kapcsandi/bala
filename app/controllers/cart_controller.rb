class CartController < ApplicationController
  
  def add_house(house)
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
      return
    end
    if current_item then
    elsif @items.count == 3
      flash[:notice] = t('cart_limit')
    else
      @items << house.id
    end
  end

  def remove_house
    begin
    current_item = @items.find {|item|item == house.id}
    rescue
      return
    end
    if current_item
      @items.delete(house.id)
    else
#      flash[:notice] = "Nincs a kosárban. Ejnye!"
    end
  end
end
