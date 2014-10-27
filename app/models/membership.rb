class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :semester
  belongs_to :committee

  validates :semester_id, :committee_id, :member_id, :reason, presence: true

  scope :unique, -> { group(:member_id) }
  scope :semester, -> semester { where(semester_id: Semester.find_by_name(semester).id) }
  scope :dce, -> member { where(member_id: Member.find_by_dce(member).id) }
  scope :approved, -> { where(approved: true) }
  scope :needs_approval, -> { where(approved: nil) }
end
