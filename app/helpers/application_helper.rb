# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    if session[:cart].nil?
      0
    else
      session[:cart].items.count
    end
  end
end
