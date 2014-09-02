require 'csv'
Scoreboard::App.controllers :memberships,  conditions: {authorize: true} do

  get :index, map: '/api/memberships', provides: [:json, :csv] do
    @semester = Semester.current_semester
    unless @semester.nil?
      @memberships = @semester.memberships
      @memberships = @memberships.unique if params[:unique]
    else
      @memberships = []
    end
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

  post :create, map: '/api/memberships' do
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

end
