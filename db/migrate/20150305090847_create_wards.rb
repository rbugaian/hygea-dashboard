class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards do |t|
      t.integer :room_number
      t.integer :capacity
      t.timestamps
    end
  end
end
