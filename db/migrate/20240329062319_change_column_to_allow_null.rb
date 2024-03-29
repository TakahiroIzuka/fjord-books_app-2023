class ChangeColumnToAllowNull < ActiveRecord::Migration[7.0]
  def up
    change_column_null :comments, :user_id, null: true
  end

  def down
    change_column_null :comments, :user_id, null: false
  end
end
