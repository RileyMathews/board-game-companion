class DropRollResults < ActiveRecord::Migration[7.0]
  def change
    drop_table :roll_results
  end
end
