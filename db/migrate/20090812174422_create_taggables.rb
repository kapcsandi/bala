class CreateTaggables < ActiveRecord::Migration
  def self.up
    create_table :taggables do |t|
#      t.string :name
      t.string :context

      t.timestamps
    end
    Taggable.create_translation_table! :name => :string
  end

  def self.down
    Taggable.drop_translation_table!
    drop_table :taggables
  end
end
