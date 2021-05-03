class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, :unique => true, :null => false, :default => ""
  end
end
