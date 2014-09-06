Scoreboard::App.controllers :members do

  get :show, map: '/api/members/:dce', provides: [:json] do
    @member = Member.find_by_dce(params[:dce])
    if params[:semester].nil?
      @semester = Semester.current_semester
    else
      @semester = Semester.find_by_name(params[:semester])
    end
    render 'members/show'
  end


end
