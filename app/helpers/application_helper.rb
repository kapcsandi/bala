# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    session[:cart].items.count unless session[:cart].nil?
  end
end
