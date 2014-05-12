module Scoreboard
  class App < Padrino::Application
    register CompassInitializer
    register Padrino::Rendering
    register Padrino::Helpers
    use ActiveRecord::ConnectionAdapters::ConnectionManagement

    enable :sessions
    enable :flash

    layout :application


    before do
      @admin = !session[:user].nil? || settings.environment == :development
    end

    get :index do
      render 'home/index'
    end

    after do
      ActiveRecord::Base.connection.close
    end

    def self.authorize(authorized)
      condition do
        halt 403, 'Not authorized' unless @admin
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

  end
end