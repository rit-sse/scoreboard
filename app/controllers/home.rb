Scoreboard::App.controllers :home do
  get :high_scores, map: '/api/high_scores', provides: [:json] do
    if params[:semester]
      @semester = Semester.find_by_name(params[:semester])
    else
      @semester = Semester.current_semester
    end
    @members = Member.high_score(@semester)
    unless @semester.nil?
      render 'home/high_scores'
    else
      [].to_json
    end
  end
end
