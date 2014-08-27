require 'csv'
Scoreboard::App.controllers :memberships,  conditions: {authorize: true} do

  get :index, map: '/memberships', provides: [:html, :csv] do
    @semester = Semester.current_semester
    unless @semester.nil?
      @memberships = @semester.memberships
      @memberships = @memberships.unique if params[:unique]
    else
      @memberships = []
    end
    case content_type
    when :html
      render 'memberships/index'
    when :csv
      CSV.generate do |csv|
        csv << ["Date", "DCE", "First Name", "Last Name", "Committee", "Reason"]
        @memberships.each do |membership|
          csv << [
            membership.date.strftime('%m/%d/%Y'),
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

  get :new, map: '/memberships/new' do
    render 'memberships/new'
  end

  post :create, map: '/memberships' do
    Member.create(params[:member]) # incase it doesn't exist
    @membership = Membership.new(params[:membership])
    @membership.member = Member.find_by_dce(params[:member][:dce])
    @membership.semester = Semester.current_semester

    if @membership.save
      flash[:success] = 'Membership was successfully created'
      redirect_to '/scoreboard/memberships/new'
    else
      render 'memberships/new'
    end
  end

end
