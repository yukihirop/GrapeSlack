class RemoveSlackFromSummary < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :summaries, :slacks
    remove_reference :summaries, :slack, index: true
  end
end
