class CreateRollResults < ActiveRecord::Migration[7.0]
  def change
    create_table :roll_results do |t|
      t.references :face, null: false, foreign_key: true
      t.references :roll, null: false, foreign_key: true
      t.boolean :archived, null: false, default: false

      t.timestamps
    end
  end
end
