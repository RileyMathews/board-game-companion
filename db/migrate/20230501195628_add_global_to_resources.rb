class AddGlobalToResources < ActiveRecord::Migration[7.0]
  def change
    add_column :resources, :global, :boolean, null: false, default: false
  end
end
