class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.references :summary, foreign_key: true
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :slack_url
      t.string :slack_message

      t.timestamps
    end
  end
end
