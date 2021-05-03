class CreateTanks < ActiveRecord::Migration[6.0]
  def change
    create_table :tanks do |t|
      t.string :tank_name
      t.string :tank_icon
      t.integer :tank_type
      t.timestamps
    end
  end
end
