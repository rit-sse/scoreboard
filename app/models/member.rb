class Member < ActiveRecord::Base
  has_many :memberships

  validates :dce, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def memberships_for(semester)
    member.membership.where(semester_id: semester.id)
  end
end
