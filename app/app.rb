module Scoreboard
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers
    register Sinatra::AssetPack
    register Sinatra::HasScope
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    set :session_secret, File.read(Padrino.root('.session_key')) if File.exists?(Padrino.root('.session_key'))
    assets do
      serve '/js',     from: 'assets/js'
      serve '/css',    from: 'assets/css'
      serve '/bc', from: 'assets/bower_components'

      js :bower, '/js/bower_components.js', [
        '/bc/jquery/dist/jquery.js',
        '/bc/angular/angular.js',
        '/bc/angular-ui-router/release/angular-ui-router.js',
        '/bc/bootstrap-sortable/Scripts/bootstrap-sortable.js',
        '/bc/moment/min/moment.min.js',
        '/bc/angular-bootstrap/ui-bootstrap-tpls.min.js',
        '/bc/lodash/dist/lodash.min.js',
        '/bc/restangular/dist/restangular.min.js',
        '/js/angular-strap/angular-strap.min.js',
        '/js/angular-strap/angular-strap.tpl.min.js'
      ]

      js :scoreboard, '/js/angular_scoreboard.js', [
        '/js/scoreboard.js',
        '/js/rest/rest.js',
        '/js/home/home.js',
        '/js/committees/committees.js',
        '/js/memberships/memberships.js',
        '/js/members/members.js',
        '/js/semesters/semesters.js',
        '/js/**/*.js'
      ]

      css :app, '/css/app.css', [
        '/css/application.css',
        '/bc/bootstrap-sortable/Contents/bootstrap-sortable.css'
      ]

      js_compression :uglify, mangle: false
      css_compression :sass
    end

    enable :sessions
    enable :flash

    get :templates, map: '/templates/:dir/:file' do
      render "templates/#{params[:dir]}/#{params[:file]}"
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
      if request.url.end_with?('css')
        headers "Content-Type" => "text/css;charset=utf-8"
      end
      ActiveRecord::Base.connection.close
    end
  end
end
