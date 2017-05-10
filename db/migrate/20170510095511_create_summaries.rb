class CreateSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :summaries do |t|
      t.string :title, null:false, length: 255
      t.references :slack, foreign_key: true

      t.timestamps
    end
  end
end
