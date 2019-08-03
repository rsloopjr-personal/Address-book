class CreateContactGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_groups do |t|
      t.string :group_name

      t.timestamps
    end
  end
end
