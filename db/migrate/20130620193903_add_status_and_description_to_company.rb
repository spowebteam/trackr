class AddStatusAndDescriptionToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :status, :integer
    add_column :companies, :description, :string
    remove_column :companies, :identifier, :string
  end
end
