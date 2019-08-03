class AddCascadeOnDelete < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :contact_groups, :users 
    add_foreign_key :contact_groups, :users, on_delete: :cascade
    remove_foreign_key :contacts, :contact_groups 
    add_foreign_key :contacts, :contact_groups, on_delete: :cascade
    remove_foreign_key :contacts, :users 
    add_foreign_key :contacts, :users, on_delete: :cascade
  end
end
