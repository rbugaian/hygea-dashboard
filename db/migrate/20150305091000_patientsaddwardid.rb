class Patientsaddwardid < ActiveRecord::Migration
  def change
    add_column :patients, :ward_id, :integer
    
  end
end
