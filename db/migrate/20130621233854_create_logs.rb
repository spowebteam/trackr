class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :content
      t.references :user
      t.references :contact
      t.references :company
      t.integer :status

      t.timestamps
    end
    add_index :logs , [:company_id,:created_at]
    add_index :logs , [:user_id,:created_at]

  end

end
