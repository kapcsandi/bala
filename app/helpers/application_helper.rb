# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    cart = find_cart
    cart.items.size
  end
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
end
