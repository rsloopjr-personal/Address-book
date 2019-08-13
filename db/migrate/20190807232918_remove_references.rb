class RemoveReferences < ActiveRecord::Migration[6.0]
  def change
    remove_reference :contacts, :user
    remove_reference :contact_groups, :user
  end
end
