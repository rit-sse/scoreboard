Scoreboard::App.controllers :semesters do

  get :index, map: '/api/semesters', provides: [:json] do
    @semesters = Semester.all
    render 'semesters/index'
  end

  post :create, map: '/api/semesters', authorize: true, provides: [:json] do
    params = JSON.parse(request.body.read, symbolize_names: true)
    @semester = Semester.new(params[:semester])
    @semester.start_date = Date.parse(params[:semester][:start_date])
    @semester.end_date = Date.parse(params[:semester][:end_date])

    if @semester.save
      { notice: 'Membership was successfully created' }.to_json
    else
      [422, {}, { errors: @semester.errors.full_messages }.to_json]
    end
  end

  get :show, map: '/api/semesters/:name', provides: [:json, :csv] do
    @semester = Semester.find_by_name(params[:name])
  end

end
