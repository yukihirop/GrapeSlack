class AddNicknameColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nickname, :string, null:false
  end
end
