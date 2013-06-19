class CreateCompaniesTeamsTable < ActiveRecord::Migration
  def change
    create_table :companies_teams, :id => false do |t|
      t.references :team
      t.references :company
    end
    add_index :companies_teams, :company_id
    add_index :companies_teams, :team_id
  end
end
