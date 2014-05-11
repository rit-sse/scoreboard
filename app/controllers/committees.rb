MembershipTracker::App.controllers :committees do

  def committee_params
    params.require(:committee).permit(:name)
  end

  get :show, map: '/committees/new' do
    @committee = Committee.new
    render 'committees/new'
  end

  post :create, map: '/committees' do
    @committee = Committee.new(committee_params)

    if @committees.save
      flash[:notice] = 'Committee was successfully created'
      redirect_to 'index/home'
    else
      render 'committees/new'
    end
  end

end