class RootController < ApplicationController
  def index
    @categories = Taggable.find_by_field('category').tags.map{|tag| { :name => tag.name, :house => tag.houses.first }}
  end

end
