class CreateRolls < ActiveRecord::Migration[7.0]
  def change
    create_table :rolls do |t|
      t.references :roll_log, null: false, foreign_key: true
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end
