require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

namespace :assets do
  task :compile do
    `compass compile app/sass/application.scss --css-dir=public/stylesheets`
  end
end