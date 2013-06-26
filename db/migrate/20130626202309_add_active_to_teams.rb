class AddActiveToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :active, :boolean, default:true
  end
end
