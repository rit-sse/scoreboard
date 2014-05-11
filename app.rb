require 'sinatra/base'
require 'sinatra/activerecord'
require 'slim'
require 'pg'

class Tracker < Sinatra::Base
  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  configure :production do
    set :db, URI.parse('postgres://localhost/membership_production')
  end

  configure :development do
    set :db, URI.parse('postgres://localhost/membership_development')
  end

  configure do
    ActiveRecord::Base.establish_connection(
        :adapter => settings.db.scheme == 'postgres' ? 'postgresql' : settings.db.scheme,
        :host     => settings.db.host,
        :username => settings.db.user,
        :password => settings.db.password,
        :database => settings.db.path[1..-1],
        :encoding => 'utf8'
    )
  end

  before do
    @admin = !session[:user].nil? || settings.environment == :development
  end

  get '/' do
    slim :index
  end

  after do
    ActiveRecord::Base.connection.close
  end

  run! if app_file == $0
end