class CreateConditions < ActiveRecord::Migration
  def self.up
    create_table :conditions do |t|

      t.timestamps
    end
    Condition.create_translation_table! :name => :string
  end

  def self.down
    Condition.drop_translation_table!
    drop_table :conditions
  end
end
