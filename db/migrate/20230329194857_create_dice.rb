class CreateDice < ActiveRecord::Migration[7.0]
  def change
    create_table :dice do |t|
      t.string :name
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
