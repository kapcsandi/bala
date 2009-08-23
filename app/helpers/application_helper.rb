# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def empties_helper
    empties = House.column_names.select{|name| name.match(/_id/) }
    empties += ['accomodation', 'room_types_ground', 
                'room_types_1st_floor', 'room_types_2nd_floor', 
                'room_types_mansard', 'owner_speaks', 
                'category']
    empties.select{|field| Taggable.find_by_field(field).nil? }
  end
end
