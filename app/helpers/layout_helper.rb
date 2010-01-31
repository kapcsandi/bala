# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end
  
  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def breadcrumb
    html, param = [], {}
    html << link_to(t(:root), root_path) unless controller_name == 'root' and action_name == 'index'
    if controller_name == 'houses'
      if params[:advanced]
				param.merge!({ :advanced => '' })
        html << link_to(t(:detailed_search), houses_path( param ))
			else
        html << link_to(t('search.button'), houses_path(param))
			end
			if params[:discount]
        html << link_to(t(:special_offers), special_offers_path(param))
      end
      if params[:category]
        html << link_to(params[:category], houses_path(param.merge!(:category => params[:category])))
      end
			begin
				where = params[:q][:where]
			rescue
				where = nil
			end
      unless where.nil? or where.empty?
        html << link_to(where, houses_path(param.merge!( 'q[where]' => where)))
      end
			begin
				house_type = params[:q][:type]
			rescue
				house_type = nil
			end
			unless house_type.nil? or house_type.empty?
        html << link_to(house_type, houses_path(param.merge!( 'q[type]' => house_type)))
			end
			if action_name == 'show'
				where = @content_for_title.split(', ')[-1]
        html << link_to(where, houses_path(param.merge!( 'q[where]' => where)))
				house_type = @content_for_title.split(', ')[0]
        html << link_to(house_type, houses_path(param.merge!( 'q[type]' => house_type)))
			end
    end
    html << @content_for_title
    t('you_are_here') + html.join('<span> > </span>')
  end
end
