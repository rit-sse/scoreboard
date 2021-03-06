require 'csv'
Scoreboard::App.controllers :memberships do
  has_scope :memberships, :unique, type: :boolean
  has_scope :memberships, :semester
  has_scope :memberships, :dce

  get :index, map: '/api/memberships', provides: [:json, :csv] do
    params["semester"] ||= Semester.current_semester.name
    logger.info(params)
    @memberships = apply_scopes(:memberships, Membership, params).approved
    case content_type
    when :json
      render 'memberships/index'
    when :csv
      CSV.generate do |csv|
        csv << ["Date", "DCE", "First Name", "Last Name", "Committee", "Reason"]
        @memberships.each do |membership|
          csv << [
            membership.created_at.strftime('%m/%d/%Y'),
            membership.member.dce,
            membership.member.first_name,
            membership.member.last_name,
            membership.committee.name,
            membership.reason
          ]
        end
      end
    end
  end

  get :admin_index, map: '/api/admin/memberships', admin: true, provides: [:json] do
    @memberships = Semester.current_semester.memberships.needs_approval
    render 'memberships/index'
  end

  post :create, map: '/api/memberships', authorize: true, provides: [:json] do
    params = JSON.parse(request.body.read, symbolize_names: true)
    Member.create(params[:member]) # incase it doesn't exist
    @membership = Membership.new(params[:membership])
    @membership.member = Member.find_by_dce(params[:member][:dce])
    @membership.semester = Semester.current_semester

    if @membership.save
      { notice: 'Membership was successfully created' }.to_json
    else
      [422, {}, { errors: @membership.errors.full_messages }.to_json]
    end
  end

  put :update, map: '/api/memberships/:id', admin: true, provides: [:json] do
    @membership = Membership.find(params[:id])
    params = JSON.parse(request.body.read, symbolize_names: true)
    if @membership.update(params)
      { notice: 'Membership was successfully updated' }.to_json
    else
      [422, {}, { errors: @membership.errors.full_messages }.to_json]
    end
  end


end
