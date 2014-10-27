class AddApprovedToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :approved, :boolean
    reversible do |dir|
      dir.up do
        Membership.update_all(approved: true)
      end

      dir.down {}
    end
  end
end
