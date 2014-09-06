require 'digest/md5'

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
    Hash[semester.memberships.group_by { |membership| membership.member }.to_a
      .sort{|a,b| b[1].count <=> a[1].count}].keys
  end


  def gravatar
    email_address = "#{dce}@rit.edu".downcase
    hash = Digest::MD5.hexdigest(email_address)
    "http://www.gravatar.com/avatar/#{hash}?d=mm&s=25"
  end
end
