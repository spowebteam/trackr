class AddTypeToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :type, :string
  end
end
