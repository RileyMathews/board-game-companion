class CreateFaces < ActiveRecord::Migration[7.0]
  def change
    create_table :faces do |t|
      t.references :die, null: false, foreign_key: true
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
