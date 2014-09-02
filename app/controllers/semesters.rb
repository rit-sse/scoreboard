Scoreboard::App.controllers :semesters, conditions: {authorize: true} do

  get :index, map: '/api/semesters', provides: [:json] do
    @semesters = Semester.all
    render 'semesters/index'
  end

  post :create, map: '/semesters' do
    @semester = Semester.new(params[:semester])
    @semester.start_date = Date.strptime(params[:semester][:start_date], '%m/%d/%Y')
    @semester.end_date = Date.strptime(params[:semester][:end_date], '%m/%d/%Y')

    if @semester.save
      flash[:success] = 'Semester was successfully created'
      redirect_to '/scoreboard'
    else
      render 'semesters/new'
    end
  end

  get :show, map: '/semesters/:name', provides: [:html, :csv] do
    @semester = Semester.find_by_name(params[:name])
    halt 404 if @semester.nil?
    @memberships = @semester.memberships
    @memberships = @memberships.unique if params[:unique]
    case content_type
    when :html
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

end
