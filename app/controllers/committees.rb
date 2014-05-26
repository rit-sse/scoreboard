Scoreboard::App.controllers :committees, conditions: {authorize: true} do
  get :new, map: '/committees/new' do
    render 'committees/new'
  end

  post :create, map: '/committees' do
    @committee = Committee.new(params[:committee])

    if @committee.save
      flash[:success] = 'Committee was successfully created'
      redirect_to '/scoreboard'
    else
      render 'committees/new'
    end
  end
end