class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :reason
      t.references :member
      t.references :committee
      t.references :semester

      t.timestamps
    end
  end
end
