Scoreboard::App.controllers :members do

  get :show, map: '/members/:dce' do
    @member = Member.find_by_dce(params[:dce])
    @semester = Semester.find_by_name(params[:semester]) || Semester.current_semester
    render 'members/show'
  end

end
