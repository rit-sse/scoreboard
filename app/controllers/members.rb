Scoreboard::App.controllers :members do

  get :show, map: '/members/:dce' do
    @member = Member.find_by_dce(params[:dce])
    @semester = Semester.find_by_name(params[:semester]) || Semester.current_semester
    render 'members/show'
  end

  get :high_scores, map: '/api/members/high_scores', provides: [:json] do
    if params[:semester]
      @semester = Semester.find_by_name(params[:semester])
    else
      @semester = Semester.current_semester
    end
    @members = Member.high_score(@semester)
    unless @semester.nil?
      render 'members/high_scores'
    else
      [].to_json
    end
  end

end
