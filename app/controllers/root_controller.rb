class RootController < ApplicationController
  def index
    @categories = Taggable.find_by_field('category').tags.map{|tag| { :name => tag.name, :house => tag.houses.first }}
    tag = Taggable.find_by_field('hidden_tags').tags.first.id
    @pictures = House.scroll_pictures(tag).sort_by {rand}
  end
end
