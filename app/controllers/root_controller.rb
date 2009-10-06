class RootController < ApplicationController
  def index
    @categories = Taggable.find_by_field('category').tags.map{|tag| { :name => tag.name, :house => tag.houses.first }}
  end

  def contact
    redirect_to_index("Not implemented yet.")
  end

  def programs
    redirect_to_index("Not implemented yet.")
  end

private
  
  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end
end
