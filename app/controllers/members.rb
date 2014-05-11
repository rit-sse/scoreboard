MembershipTracker::App.controllers :members do

  get :show, map: '/members/:dce' do
    @member = Member.find_by_dce(params[:dce])
    @semesters = Semester.all
    render 'members/show'
  end

end