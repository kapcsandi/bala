class CreateRoomTypes < ActiveRecord::Migration
  def self.up
    create_table :room_types do |t|
#      t.string :name
      t.timestamps
    end
    RoomType.create_translation_table! :name => :string
  end
  
  def self.down
    RoomType.drop_translation_table!
    drop_table :room_types
  end
end
