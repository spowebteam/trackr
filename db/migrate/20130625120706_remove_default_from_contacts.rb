class RemoveDefaultFromContacts < ActiveRecord::Migration
  def up
  	remove_column :contacts, :default
  end
  def down
  	add_column :contacts, :default, :boolean
  end
end
