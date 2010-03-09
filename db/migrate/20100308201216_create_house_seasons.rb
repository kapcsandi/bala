class CreateHouseSeasons < ActiveRecord::Migration
  def self.up
    create_table :house_seasons do |t|
      t.integer :house_id
      t.integer :season_id

      t.timestamps
    end
  end

  def self.down
    drop_table :house_seasons
  end
end
