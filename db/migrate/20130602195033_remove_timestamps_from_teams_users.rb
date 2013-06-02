class RemoveTimestampsFromTeamsUsers < ActiveRecord::Migration
  def up
    remove_column :teams_users, :created_at
    remove_column :teams_users, :updated_at
  end

  def down
    add_column :teams_users, :updated_at, :string
    add_column :teams_users, :created_at, :string
  end
end
