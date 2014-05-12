class Member < ActiveRecord::Base
  has_many :memberships

  validates :dce, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def memberships_for(semester)
    memberships.where(semester_id: semester.id)
  end

  def self.high_score(semester)
    all.sort{|a,b| b.memberships_for(semester) <=> a.memberships_for(semester)}.first(10)
  end
end
