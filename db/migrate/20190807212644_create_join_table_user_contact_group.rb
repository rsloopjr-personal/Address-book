class CreateJoinTableUserContactGroup < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :contact_groups
  end
end
