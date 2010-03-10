class AddActiveToSeasons < ActiveRecord::Migration
  def self.up
   add_column :seasons, :active, :integer, :default => 0
  end

  def self.down
    remove_column :seasons, :active
  end
end
