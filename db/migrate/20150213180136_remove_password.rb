class RemovePassword < ActiveRecord::Migration
  def change
    remove_column :doctors, :password
  end
end
