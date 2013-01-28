class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.integer :level
      t.string  :phone
      t.string  :identifier

      t.timestamps
    end
  end
end
