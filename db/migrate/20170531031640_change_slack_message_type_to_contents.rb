class ChangeSlackMessageTypeToContents < ActiveRecord::Migration[5.1]

  def up
    change_column :contents, :slack_message,  :text,     null:false
  end

  def down
    change_column :contents, :slack_message,  :string,   null:false
  end

end
