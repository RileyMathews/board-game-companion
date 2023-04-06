class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :min, null: false, default: 0
      t.integer :max, null: false, default: 1000

      t.timestamps
    end

    add_index :resources, [:game_id, :name], unique: true
  end
end
