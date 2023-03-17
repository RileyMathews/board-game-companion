class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.uuid :uuid, null: false, default: "gen_random_uuid()"
      t.string :slug, null: false
      t.references :created_by, null: false

      t.timestamps
    end
    add_index :games, :name, unique: true
    add_index :games, :uuid, unique: true
    add_index :games, :slug, unique: true
    add_foreign_key :games, :users, column: :created_by_id
  end
end
