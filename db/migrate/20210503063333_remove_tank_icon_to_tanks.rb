class RemoveTankIconToTanks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tanks, :tank_icon, :string
  end
end
