class RootController < ApplicationController
  def index
    if admin?
      search = EventLog.searchlogic
      @logs, @logs_count = search.all, search.count
    else
      @categories = Taggable.find_by_field('category').tags.map{|tag| { :name => tag.name, :house => tag.houses.first }}
      begin
        tag = Taggable.find_by_field('hidden_tags').tags.first.id
      rescue
        tag = []
      end
      @pictures = House.scroll_pictures(tag).sort_by {rand}[0..9]
    end
  end
end
