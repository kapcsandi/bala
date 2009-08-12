module TaggablesHelper
  def add_tag_link(name, form)
    link_to_function name do |page|
      tag = render(:partial => 'tag', :locals => { :pf => form, :tag => Tag.new })
      page << %{
        var new_tag_id = "new_" + new Date().getTime();
        $('tags').insert({ bottom: "#{ escape_javascript tag }".replace(/new_\\d+/g, new_tag_id) });
      }
    end
  end
end
