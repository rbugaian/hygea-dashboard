class AddPasswordToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :password, :string
  end
end
