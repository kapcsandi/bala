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
    html = []
    html << link_to(t(:home), '/') unless controller_name == 'root' and action_name == 'index'
    if controller_name == 'houses'
      if params[:advanced] == '1'
        html << link_to(t(:detailed_search), houses_path( :advanced => '1')) 
      elsif params[:q]
        html << link_to(t(:search), houses_path) 
			end
			if params[:discount]
        html << link_to(t(:special_offers), special_offers_path)
      elsif params[:category]
        html << link_to(params[:category], houses_path(:category => params[:category]))
      end
      if params[:q] and params[:q][:where]
        html << link_to(params[:q][:where], houses_path( 'q[where]' => params[:q][:where])) 
      end
    end
    html << @content_for_title #if show_title?
    t('you_are_here') + html.join(' > ')
  end
end
