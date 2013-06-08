class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :identifier
      t.string :location
      t.string :phone
      t.string :url
      t.string :address

      t.timestamps
    end
  end
end
