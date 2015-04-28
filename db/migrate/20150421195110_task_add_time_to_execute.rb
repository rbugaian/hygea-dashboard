class TaskAddTimeToExecute < ActiveRecord::Migration
  def change
  	add_column :tasks, :date_to_execute, :datetime
  end
end
