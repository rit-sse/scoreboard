require 'sinatra/base'
require 'slim'

class Tracker < Sinatra::Base
  get '/' do
    slim :index
  end
  run! if app_file == $0
end