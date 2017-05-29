class ChangeColumnsToContent < ActiveRecord::Migration[5.1]

  def up
    change_column :contents, :name,           :string,   null:false
    change_column :contents, :nickname,       :string,   null:false
    change_column :contents, :slack_url,      :string,   null:false
    change_column :contents, :slack_message,  :string,   null:false
  end

  def down
    change_column :contents, :name,           :string
    change_column :contents, :nickname,       :string
    change_column :contents, :slack_url,      :string
    change_column :contents, :slack_message,  :string
  end

end
