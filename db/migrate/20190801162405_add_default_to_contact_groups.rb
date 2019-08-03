class AddDefaultToContactGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_groups, :default, :boolean
  end
end
