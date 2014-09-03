Scoreboard::App.controllers :semesters do

  get :index, map: '/api/semesters', provides: [:json] do
    @semesters = Semester.all
    render 'semesters/index'
  end

  post :create, map: '/semesters', authorize: true do
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
  end

end
