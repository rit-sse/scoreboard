Scoreboard::App.controllers :semesters, conditions: {authorize: true} do

  get :new, map: '/semesters/new' do
    render 'semesters/new'
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

  get :show, map: '/semesters/:name' do
    @semester = Semester.find_by_name(params[:name])
    halt 404 if @semester.nil?
    @memberships = @semester.memberships
    @memberships = @memberships.unique if params[:unique]
    render 'memberships/index'
  end

end