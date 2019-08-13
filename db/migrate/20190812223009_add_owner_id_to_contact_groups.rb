class AddOwnerIdToContactGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_groups, :owner_id, :integer
  end
end
