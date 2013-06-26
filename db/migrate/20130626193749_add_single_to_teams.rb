class AddSingleToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :single, :boolean
  end
end
