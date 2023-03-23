class CreateDice < ActiveRecord::Migration[7.0]
  def change
    create_table :dice do |t|
      t.references :game, null: false, foreign_key: true
      t.references :created_by, null: false
      t.string :name, null: false
      t.uuid :uuid, null: false, default: "gen_random_uuid()"

      t.timestamps
    end
    add_index :dice, :uuid, unique: true
    add_index :dice, [:name, :game_id], unique: true
    add_foreign_key :dice, :users, column: :created_by_id
  end
end
