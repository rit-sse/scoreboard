class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :dce
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
