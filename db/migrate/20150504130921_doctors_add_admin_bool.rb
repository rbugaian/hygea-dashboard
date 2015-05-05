class DoctorsAddAdminBool < ActiveRecord::Migration
  def change
  	add_column :doctors, :is_admin, :boolean, default: false
  end
end
