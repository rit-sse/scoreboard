Scoreboard::App.controllers :memberships,  conditions: {authorize: true} do
  get :index, map: '/memberships' do
    @semester = Semester.current_semester
    @memberships = @semester.memberships
    render 'memberships/index'
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
      flash[:notice] = 'Membership was successfully created'
      redirect_to 'memberships'
    else
      render 'memberships/new'
    end
  end

end