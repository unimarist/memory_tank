class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :user_icon, true
  end
end
