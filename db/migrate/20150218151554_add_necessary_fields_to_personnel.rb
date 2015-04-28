class AddNecessaryFieldsToPersonnel < ActiveRecord::Migration
  def change
  	add_column :personnels, :status, :integer
  end
end
