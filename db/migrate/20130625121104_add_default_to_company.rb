class AddDefaultToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :default_contact_id, :integer
  end
end
