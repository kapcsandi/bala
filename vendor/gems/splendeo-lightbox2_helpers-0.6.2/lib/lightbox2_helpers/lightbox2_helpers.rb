module Lightbox2Helpers
  VERSION = '0.5'

  # Returns the default_options hash.  These options are by default provided to every calendar_date_select control, unless otherwise overrided.
  # 
  # Example:
  #   # At the bottom of config/environment.rb:
  #   Lightbox2Helper.default_options.update(
  #     ... whatever options you want to inser here
  #   )
  def self.default_options
    @default_options ||= { }
  end

end
