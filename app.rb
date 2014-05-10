require 'sinatra/base'
require 'slim'
require './config/environments'
require 'active_support/core_ext'
require 'padrino-helpers'

class Tracker < Sinatra::Base
  register Padrino::Helpers
  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  get '/' do
    slim :index
  end

  after do
    ActiveRecord::Base.connection.close
  end
  run! if app_file == $0
end