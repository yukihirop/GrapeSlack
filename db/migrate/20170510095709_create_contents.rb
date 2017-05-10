class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :first_name,   null:false
      t.string :last_name,    null:false
      t.string :slack_url,    null:false
      t.string :slack_message,null:false
      t.references :summary,  foreign_key: true

      t.timestamps
    end
  end
end
