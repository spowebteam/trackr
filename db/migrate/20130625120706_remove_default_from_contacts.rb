class RemoveDefaultFromContacts < ActiveRecord::Migration
  def change
  	remove_column :contacts, :default, :boolean
  end
end
