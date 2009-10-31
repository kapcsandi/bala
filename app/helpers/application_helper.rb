# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    if session[:cart]
      session[:cart].items.count
    else
      0
    end
  end
end
