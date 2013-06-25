class AddStatusAndDescriptionToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :status, :integer
    add_column :companies, :description, :string
  end
  def up
  	remove_column :companies, :identifier
  end
  def down
  	add_column :companies, :identifier, :string
  end
end
