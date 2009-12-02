# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    cart = find_cart
    cart.items.size
  end
  
  def find_cart
    session[:cart] ||= Cart.new
  end

  def show_hide(id)
    %Q^<a class="fold" id="show_#{id}" onclick="Effect.BlindDown('#{id}');$('show_#{id}').hide();$('hide_#{id}').show();return false;" style="display:none">[+]</a>
    <a class="fold" id="hide_#{id}" onclick="$('show_#{id}').show();$('hide_#{id}').hide();Effect.BlindUp('#{id}');return false;" style="display:block">[-]</a>^
  end
end
