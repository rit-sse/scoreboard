Scoreboard::App.controllers :home do
  get :high_scores, map: '/api/high_scores', provides: [:json] do
    if params[:semester]
      @semester = Semester.find_by_name(params[:semester])
    else
      @semester = Semester.current_semester
    end
    unless @semester.nil?
      @members = Member.high_score(@semester)
      render 'home/high_scores'
    else
      [].to_json
    end
  end
end
