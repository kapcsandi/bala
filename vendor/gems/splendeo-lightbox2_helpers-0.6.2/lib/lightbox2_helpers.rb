require "lightbox2_helpers/lightbox2_helpers.rb"
require "lightbox2_helpers/form_helpers.rb"
require "lightbox2_helpers/includes_helper.rb"

if Object.const_defined?(:Rails) && File.directory?(Rails.root.to_s + "/public")  
  ActionView::Helpers::FormHelper.send(:include, Lightbox2Helpers::FormHelpers)
  ActionView::Base.send(:include, Lightbox2Helpers::FormHelpers)
  ActionView::Base.send(:include, Lightbox2Helpers::IncludesHelper)
  
  # egarcia: all this is adapted from calendar_date_select, so I'm not touching it
  # Filthy backwards compatibility hooks... grumble
  if ([Rails::VERSION::MAJOR, Rails::VERSION::MINOR] <=> [2, 2]) == -1
    ActionView::Helpers::InstanceTag.class_eval do
      def self.new_with_backwards_compatibility(object_name, method_name, template_object, object = nil)
        new(object_name, method_name, template_object, nil, object)
      end
    end
    
  else
    ActionView::Helpers::InstanceTag.class_eval do
      class << self; alias new_with_backwards_compatibility new; end
    end
  end

  # install files
  unless File.exists?(RAILS_ROOT + '/public/javascripts/lightbox2_helpers/lightbox.js')
    ['/public', '/public/javascripts/lightbox2_helpers', '/public/stylesheets/lightbox2_helpers', '/public/images/lightbox2_helpers'].each do |dir|
      source = File.dirname(__FILE__) + "/../#{dir}"
      dest = RAILS_ROOT + dir
      FileUtils.mkdir_p(dest)
      FileUtils.cp(Dir.glob(source+'/*.*'), dest)
    end
  end
end