class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :semester
  belongs_to :committee
end