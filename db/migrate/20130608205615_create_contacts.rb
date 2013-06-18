class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :designation
      t.string :landline
      t.string :mobile
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
