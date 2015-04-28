class AddAuthTokenToPersonnel < ActiveRecord::Migration
  def change
  	add_column :personnels, :auth_token, :string
  	add_index :personnels, :auth_token, unique: true
  end
end
