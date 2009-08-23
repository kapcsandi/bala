class CreateDiscounts < ActiveRecord::Migration
  def self.up
    create_table :discounts do |t|
      t.integer :house_id
      t.timestamps
    end
    Discount.create_translation_table! :description => :string
  end
  
  def self.down
    Discount.drop_translation_table!
    drop_table :discounts
  end
end
