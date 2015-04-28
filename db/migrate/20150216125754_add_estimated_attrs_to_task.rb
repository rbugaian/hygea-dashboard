class AddEstimatedAttrsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :report, :string
    add_column :tasks, :personnel_id, :integer

    add_index :tasks, :personnel_id
  end
end
