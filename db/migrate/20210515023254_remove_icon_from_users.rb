class RemoveIconFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :user_icon, :string
  end
end
