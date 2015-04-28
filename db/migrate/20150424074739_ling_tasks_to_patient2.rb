class LingTasksToPatient2 < ActiveRecord::Migration
  def change
  	add_column :tasks, :patient_id, :integer
  end
end
