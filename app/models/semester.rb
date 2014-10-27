class Semester < ActiveRecord::Base
  has_many :memberships
  validates :name, uniqueness: true
  validates :start_date, :end_date, presence: true
  validate :semesters_should_not_overlap
  validate :start_date_should_be_after_end_date

  def self.current_semester
    where('start_date <= :today AND end_date >= :today', today: Date.today).first
  end

  def semesters_should_not_overlap
    Semester.all.each do |semester|
      if (semester.start_date..semester.end_date).cover?(start_date) || (semester.start_date..semester.end_date).cover?(end_date)
        errors.add(:semester, 'overlaps with another semester')
        break
      end
    end
  end

  def start_date_should_be_after_end_date
    errors.add(:start_date, 'is after end date') if start_date and end_date and start_date > end_date
  end
end
