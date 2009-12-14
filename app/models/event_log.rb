class EventLog < ActiveRecord::Base
  attr_accessible :user_id, :action
  belongs_to :user
  default_scope :order => 'created_at DESC'

  def self.per_page
    20
  end
end
