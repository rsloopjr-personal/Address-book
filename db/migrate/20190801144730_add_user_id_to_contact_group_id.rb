class AddUserIdToContactGroupId < ActiveRecord::Migration[6.0]
  def change
    add_reference :contact_groups, :user, foreign_key: true
  end
end
