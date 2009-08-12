class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :taggable_id

      t.timestamps
    end
    Tag.create_translation_table! :name => :string
  end

  def self.down
    Tag.drop_translation_table!
    drop_table :tags
  end
end
