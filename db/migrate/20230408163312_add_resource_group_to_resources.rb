class AddResourceGroupToResources < ActiveRecord::Migration[7.0]
  def change
    add_reference :resources, :resource_group, null: true, foreign_key: true
  end
end
