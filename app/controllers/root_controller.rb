class RootController < ApplicationController
#  caches_action :index
  
  def index
    @categories = Taggable.of_field("category").first.tags.map{|tag| { :name => tag.name, :house => tag.houses.first }}
    begin
      tag = Taggable.of_field("hidden_tags").first.tags.first.id
    rescue
      tag = []
    end
    @pictures = House.scroll_pictures(tag).sort_by {rand}[0..30]
  end
end
