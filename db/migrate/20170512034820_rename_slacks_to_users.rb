class RenameSlacksToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :slacks, :users
  end
end
