class AddTankTypeToTanks < ActiveRecord::Migration[6.0]
  def change
    add_column :tanks, :tank_type, :string
  end
end
