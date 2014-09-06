collection @memberships

attributes :reason, :created_at
child(:member) { attributes :dce, :first_name, :last_name }
child(:committee) { attributes :name }
child(:semester) { attributes :name }
