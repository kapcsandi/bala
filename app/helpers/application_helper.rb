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
end
