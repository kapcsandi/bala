module Lightbox2Helpers::IncludesHelper
  # returns the selected lightbox2_helpers stylesheet (not an array)
  def lightbox2_helpers_stylesheets()
    "lightbox2_helpers/lightbox.css"
  end

  # returns an array of javascripts needed (array)
  def lightbox2_helpers_javascripts()
    ["lightbox2_helpers/builder.js",
     "lightbox2_helpers/lightbox.js"]
  end

  # returns html necessary to load javascript and css to make lightbox2_helpers work
  def lightbox2_helpers_includes(*args)
    return "" if @lhs_already_included
    @lhs_already_included=true
    
    javascript_include_tag(*lightbox2_helpers_javascripts ) + "\n" +
    stylesheet_link_tag(*lightbox2_helpers_stylesheets ) + "\n"
  end
end
