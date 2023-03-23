class CreateFaces < ActiveRecord::Migration[7.0]
  def change
    create_table :faces do |t|
      t.integer :count
      t.string :name
      t.references :die, null: false, foreign_key: true

      t.timestamps
    end

    add_index :faces, [:name, :die_id], unique: true
  end
end
