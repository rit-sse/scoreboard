collection @members

attributes :full_name, :gravatar
node(:count) { |member| member.memberships_for(@semester).count }
