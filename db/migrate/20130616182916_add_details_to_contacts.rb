class AddDetailsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :company_id, :integer
    add_index :contacts, [:company_id]
  end
end
