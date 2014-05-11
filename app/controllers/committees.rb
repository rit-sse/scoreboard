MembershipTracker::App.controllers :committees do

  # define_method  :committee_params do
  #   params.require(:committee).permit(:name)
  # end

  get :show, map: '/committees/new' do
    @committee = Committee.new
    render 'committees/new'
  end

  post :create, map: '/committees' do
    @committee = Committee.new(params[:committee])

    if @committee.save
      flash[:notice] = 'Committee was successfully created'
      redirect_to '/'
    else
      render 'committees/new'
    end
  end

end