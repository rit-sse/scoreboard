class Committee < ActiveRecord::Base
  has_many :memberships

  validates :name, uniqueness: true
end