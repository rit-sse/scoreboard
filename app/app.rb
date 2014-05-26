module Scoreboard
  class App < Padrino::Application
    register CompassInitializer
    register Padrino::Rendering
    register Padrino::Helpers
    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    enable :sessions
    enable :flash

    layout :application

    get :index do
      @semester = Semester.current_semester
      @members = Member.high_score(@semester) unless @semester.nil?
      render 'home/index'
    end

    def self.authorize(authorized)
      condition do
        halt 403, 'Not authorized' unless signed_in?
      end if authorized
    end

    error 403 do
      render('errors/403')
    end

    error 404 do
      render('errors/404')
    end

    error 500 do
      render('errors/500')
    end

    after do
      ActiveRecord::Base.connection.close
    end
  end
end