module HousesHelper
  def link(house)
    link_to(house.code, house_path(house.id))
  end
end
