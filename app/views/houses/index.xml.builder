xml.instruct!
xml.rss "version" => "2.0", "xmlns:base" => request.domain do
  xml.channel do
    xml.title       "#{request.domain} - #{t('title_houses_found')}"
    xml.link        url_for :only_path => false, :controller => 'houses'
    xml.description "#{request.domain} - #{I18n.t(:meta_description)}"
    xml.language    I18n.locale.to_s
    @houses.each do |house|
      xml.item do
        xml.title do
          xml.cdata! "#{house.name}, #{I18n.t(:short_persons, :persons => house.persons)}"
        end
        xml.category house.house_type
        xml.link house_path(house, :only_path => false)
        xml.guid house_path(house, :only_path => false)
        xml.description do
          xml.cdata! image_tag( "http://#{request.domain}#{house.thumb}", :alt => house.name) + '<br />' + house.house_description
        end
        xml.pubDate house.updated_at.strftime("%a, %d %b %Y %H:%M:%S") + " +0100"
      end
    end
  end
end