class RenameSlackToSummaries < ActiveRecord::Migration[5.1]
  def change
    remove_reference :summaries, :slack
    add_reference :summaries, :user
  end
end
