class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :published 
      t.timestamps
    end
    Page.create_translation_table! :title => :string, :body => :text
  end

  def self.down
    Page.drop_translation_table! 
    drop_table :pages
  end
end
