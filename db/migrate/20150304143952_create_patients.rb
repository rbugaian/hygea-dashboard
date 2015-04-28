class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :doctor_id
      t.integer :personnel_id
      t.integer :idno, :limit => 8
      t.integer :blood_type
      
      t.timestamps
    end
  end
end
