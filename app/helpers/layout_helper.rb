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
    html << link_to(t(:home), '/') unless controller_name == 'root' and action_name == 'index'
    if controller_name == 'houses'
      if params[:advanced]
				param.merge!({ :advanced => '' })
        html << link_to(t(:detailed_search), houses_path( param ))
      elsif params[:commit]
        html << link_to(t(:search), houses_path) 
			end
			if params[:discount]
        html << link_to(t(:special_offers), special_offers_path(param))
      elsif params[:category]
        html << link_to(params[:category], houses_path(param.merge!(:category => params[:category])))
      end
			where = (params[:commit].nil? or params[:q][:where].nil? or params[:q][:where].empty?) ? nil : params[:q][:where]
      if where
        html << link_to(where, houses_path(param.merge!( 'q[where]' => where)))
      end
				house_type = (params[:commit].nil? or params[:q][:type].nil? or params[:q][:type].empty?) ? nil : params[:q][:type]
				if house_type
        html << link_to(house_type, houses_path(param.merge!( 'q[type]' => house_type)))
			end
			if action_name == 'show'
				html << link_to(t(:search), houses_path(param))
				where = @content_for_title.split(', ')[-1]
        html << link_to(where, houses_path(param.merge!( 'q[where]' => where)))
				house_type = @content_for_title.split(', ')[0]
        html << link_to(house_type, houses_path(param.merge!( 'q[house_type]' => house_type)))
			end
    end
    html << @content_for_title #if show_title?
    t('you_are_here') + html.join(' > ')
  end
end
