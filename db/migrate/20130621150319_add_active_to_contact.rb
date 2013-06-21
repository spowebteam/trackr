class AddActiveToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :active, :boolean
    add_index  :contacts, :active
  end
end
