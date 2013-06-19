class AddIndexToTeamsUsers < ActiveRecord::Migration
  def change
    add_index :teams_users, :user_id
    add_index :teams_users, :team_id
  end
end
