module Scoreboard
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers
    register Sinatra::AssetPack
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    assets do
      serve '/js',     from: 'assets/js'
      serve '/css',    from: 'assets/css'
      serve '/fonts',  from: 'assets/fonts'
      serve '/bc', from: 'assets/bower_components'

      js :bower, '/js/bower_components.js', [
        '/bc/jquery/dist/jquery.js',
        '/bc/angular/angular.js',
        '/bc/angular-ui-router/release/angular-ui-router.js',
        '/bc/bootstrap-sortable/Scripts/bootstrap-sortable.js',
        '/bc/moment/min/moment.min.js'
      ]

      js :scoreboard, '/js/angular_scoreboard.js', [
        '/js/scoreboard.js',
        '/js/home/home.js',
        '/js/**/*.js'
      ]

      css :app, '/css/app.css', [
        '/css/application.css',
        '/bc/angular-bootstrap-datetimepicker/src/css/datetimepicker.css',
        '/bc/bootstrap-sortable/Contents/bootstrap-sortable.css',
        '/bc/font-awesome/css/font-awesome.min.css'
      ]

      js_compression :uglify
      css_compression :sass
    end

    enable :sessions
    enable :flash

    get :templates, map: '/templates/:dir/:file' do
      render "templates/#{params[:dir]}/#{params[:file]}" rescue ''
    end

    get :all, map: '/*page', priority: :low  do
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
