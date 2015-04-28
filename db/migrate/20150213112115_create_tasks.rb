class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    
      t.string :title
      t.text :description
      t.integer :status
      t.integer :doctor_id

      t.timestamps
    end

    add_index :tasks, :doctor_id
  end
end
