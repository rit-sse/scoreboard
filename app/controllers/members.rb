MembershipTracker::App.controllers :members do

  get :show, map: 'member/:dce' do
    @member = Member.find_by_dce(params[:dce])
    render 'member/show'
  end

end