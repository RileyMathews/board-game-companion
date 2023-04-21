class RemoveArchivedFromRoll < ActiveRecord::Migration[7.0]
  def change
    remove_column :rolls, :archived, :boolean
  end
end
