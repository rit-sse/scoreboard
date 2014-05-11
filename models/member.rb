class Member < ActiveRecord::Base
  has_many :memberships

  validates :dce, uniqueness: true
end
