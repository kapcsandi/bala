class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :event_logs, :created_at
    add_index :discount_translations, :discount_id
    add_index :discount_translations, :locale
    add_index :houses_bookings, :start_at
    add_index :houses_bookings, :end_at
    add_index :house_translations, [:house_id, :locale], :uniq => true
    add_index :house_translations, :house_id
    add_index :house_translations, :locale
    add_index :pages, [:published, :path], :uniq => true
    add_index :pages, :published
    add_index :pages, :path
    add_index :page_translations, [:page_id, :locale], :uniq => true
    add_index :page_translations, :page_id
    add_index :page_translations, :locale
    add_index :seasons, [:name, :start], :uniq => true
    add_index :seasons, :name
    add_index :seasons, :start
    add_index :taggables, :field
    add_index :taggables, :position
    add_index :taggable_translations, [:taggable_id, :locale], :uniq => true
    add_index :taggable_translations, :taggable_id
    add_index :taggable_translations, :locale
    add_index :tag_translations, [:tag_id, :locale], :uniq => true
    add_index :tag_translations, :tag_id
    add_index :tag_translations, :locale
  end

  def self.down
  end
end
