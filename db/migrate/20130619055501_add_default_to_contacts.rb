class AddDefaultToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :default, :boolean
  end
end
