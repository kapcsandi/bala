class CreateEventLogs < ActiveRecord::Migration
  def self.up
    create_table :event_logs do |t|
      t.integer :user_id
      t.string :action
      t.timestamps
    end
  end
  
  def self.down
    drop_table :event_logs
  end
end
