class RemoveColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :email, :string
    remove_column :users, :password_digest, :string
  end
end
