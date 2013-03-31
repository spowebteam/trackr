class TeamsUsers < ActiveRecord::Migration
  def change
    create_table :teams_users, :id => false do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
  end
end
