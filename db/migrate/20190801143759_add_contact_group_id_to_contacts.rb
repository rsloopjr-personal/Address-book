class AddContactGroupIdToContacts < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :contact_group, foreign_key: true
  end
end
