class AddUserFromSummary < ActiveRecord::Migration[5.1]
  def change
    add_reference :summaries, :user, foreign_key: true
  end
end
