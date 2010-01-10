class Contact  < ActiveRecord::BaseWithoutTable
  column :house_id, :integer
  column :firstname, :string
  column :lastname, :string
  column :address, :string
  column :city, :string
  column :phone, :string
  column :email, :string
  column :start_at, :date
  column :end_at, :date
  column :persons, :integer
  column :children, :string
  column :with_animals, :boolean
  column :notes, :string
  validates_presence_of :house_id, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_length_of :email, :within => 5..255

  def name
    self.firstname + ' ' + self.lastname
  end


end