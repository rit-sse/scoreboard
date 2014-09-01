Scoreboard::App.controllers :committees, conditions: {authorize: true} do
  post :create, map: '/api/committees' do
    params = JSON.parse(request.body.read, symbolize_names: true)
    @committee = Committee.new(params[:committee])

    if @committee.save
      { notice: 'Committee was successfully created' }.to_json
    else
      [422, {}, { errors: @committee.errors.full_messages }.to_json]
    end
  end
end
