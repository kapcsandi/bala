# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    if session[:cart] and session[:cart].items
      session[:cart].items.size
    else
      0
    end
  end
end
