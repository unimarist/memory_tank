class RemoveTankTypeToTanks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tanks, :tank_type, :integer
  end
end
