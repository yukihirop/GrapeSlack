class AddUserFromContents < ActiveRecord::Migration[5.1]
  def change
    add_reference :contents, :user, foreign_key: true
  end
end
