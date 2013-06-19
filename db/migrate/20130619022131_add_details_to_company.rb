class AddDetailsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :poc_id, :integer
    add_column :companies, :manager_id, :integer
    add_index  :companies, [:poc_id,:manager_id]
  end
end
