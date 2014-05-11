module MembershipTracker
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
  end
end