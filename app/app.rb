module MembershipTracker
  class App < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    enable :sessions

    before do
      @admin = !session[:user].nil? || settings.environment == :development
    end

    get :index do
      slim :index
    end

    after do
      ActiveRecord::Base.connection.close
    end
  end
end