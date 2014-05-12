class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :semester
  belongs_to :committee

  validates :semester_id, :committee_id, :member_id, :reason, presence: true

  scope :unique, group(:member_id)
end