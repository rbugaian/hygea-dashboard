class AddPersonInfoToPersonnel < ActiveRecord::Migration
  def change
     add_column :personnels, :first_name, :string
     add_column :personnels, :last_name, :string
  end
end
