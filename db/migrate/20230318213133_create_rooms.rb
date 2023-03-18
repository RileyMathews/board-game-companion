class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.uuid :uuid, null: false, default: "gen_random_uuid()"
      t.string :join_code, null: false
      t.references :created_by, null: false
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
    add_index :rooms, :name, unique: true
    add_index :rooms, :slug, unique: true
    add_index :rooms, :uuid, unique: true
    add_foreign_key :rooms, :users, column: :created_by_id
  end
end
