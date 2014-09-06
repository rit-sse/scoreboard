Scoreboard::App.controllers :committees, conditions: {authorize: true} do
  post :create, map: '/api/committees', provides: [:json] do
    params = JSON.parse(request.body.read, symbolize_names: true)
    @committee = Committee.new(params[:committee])

    if @committee.save
      { notice: 'Committee was successfully created' }.to_json
    else
      [422, {}, { errors: @committee.errors.full_messages }.to_json]
    end
  end

  get :index, map: '/api/committees', provides: [:json] do
    @committees = Committee.all
    render 'committees/index'
  end
end
