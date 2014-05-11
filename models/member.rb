class Member < ActiveRecord::Base
  attr_accessible :dce
  has_many :memberships

  validates :dce, uniqueness: true
end
