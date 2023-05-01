class FixAmountName < ActiveRecord::Migration[7.0]
  def change
    rename_column :room_resources, :ammount, :amount
  end
end
