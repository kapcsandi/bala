# Author:: Trevor Menagh
# WebSite:: http://wiki.github.com/trevmex/thickbox
# Forked from http://github.com/Lipsiasoft/lightbox/tree/master
require 'action_view'

module ActionView
  module Helpers
    module ThickBoxHelper
      def self.included(base)
        base.class_eval do
          include InstanceMethods
        end
      end
      module InstanceMethods
        def thickbox_image_tag(source, destination, image_options = {}, html_options = {})
          html_options.merge!(:class => "thickbox") unless html_options[:class]
          html_options.merge!(:title => "") unless html_options[:title]
          link_to(image_tag(source, image_options), destination, html_options)
        end
        
        def thickbox_link_to(name, options = {}, html_options = {}, *parameters_for_method_reference)
          html_options.merge!(:class => "thickbox") unless html_options[:class]
          html_options.merge!(:title => "") unless html_options[:title]
          link_to(name, options, html_options, *parameters_for_method_reference)
        end
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActionView::Helpers::ThickBoxHelper
end

ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'jquery'    # Change to jquery.pack for compressed version
ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'thickbox'  # Change the thickbox.pack for compressed version