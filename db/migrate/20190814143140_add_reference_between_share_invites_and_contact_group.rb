class AddReferenceBetweenShareInvitesAndContactGroup < ActiveRecord::Migration[6.0]
  def change
    remove_column :share_invites, :contact_group_id
    add_reference :share_invites, :contact_group, foreign_key: true
    remove_foreign_key :share_invites, :contact_groups
    add_foreign_key :share_invites, :contact_groups, on_delete: :cascade
  end
end
