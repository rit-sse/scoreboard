class AddDatesToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :start_date, :date
    add_column :semesters, :end_date, :date
  end
end
