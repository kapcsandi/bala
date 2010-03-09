# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cart_items
    cart = find_cart
    cart.items.size
  end
  
  def find_cart
    session[:cart] ||= Cart.new
  end

  def show_hide(id, open=true)
    %Q!<a class="fold" id="show_#{id}" onclick="Effect.BlindDown('#{id}');$('show_#{id}').hide();$('hide_#{id}').show();return false;" style="display:#{open ? 'none' : 'block'}"><img alt="" src="/images/icons/24x24/001_27.png" /></a>
    <a class="fold" id="hide_#{id}" onclick="$('show_#{id}').show();$('hide_#{id}').hide();Effect.BlindUp('#{id}');return false;" style="display:#{open ? 'block' : 'none'}"><img alt="" src="/images/icons/24x24/001_26.png" /></a>!
  end

  def url_for(options = {})
    options ||= {}
    url = case options
    when String
      escape = true
      options
    when Hash
      options[:host] = request.host if action_name == 'print'
      options = { :only_path => options[:host].nil? }.update(options.symbolize_keys)
      escape  = options.key?(:escape) ? options.delete(:escape) : true
      @controller.send(:url_for, options)
    when :back
      escape = false
      @controller.request.env["HTTP_REFERER"] || 'javascript:history.back()'
    else
      escape = false
      polymorphic_path(options)
    end

    escape ? escape_once(url) : url
  end

  def galery?
    controller_name == 'houses' and action_name == 'show' 
  end

  def date_format
    case I18n.locale
    when :de
      '"%d.%M.%Y"'
    when :hu
      '"%Y-%m-%d"'
    else
      '"%Y-%m-%d"'
    end
  end

  def house_link(house)
    link_to(house.code, house_path(house.id))
  end
end
