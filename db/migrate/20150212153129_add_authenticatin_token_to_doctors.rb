class AddAuthenticatinTokenToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :auth_token, :string
    add_index :doctors, :auth_token, unique: true
  end
end
