class CreateShareInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :share_invites do |t|
      t.integer :sharer_id
      t.integer :receiver_id
      t.integer :contact_group_id
      t.string :status

      t.timestamps
    end
  end
end
