class AddShowedMarkerToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :was_shown, :boolean
  end
end
