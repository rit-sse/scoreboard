class Semester < ActiveRecord::Base
  has_many :memberships
  validates :name, uniqueness: true
  validates :start_date, :end_date, presence: true

  def self.current_semester
    where('start_date <= :today AND end_date >= :today', today: Date.today).first
  end
end