begin
  require 'rspec/core/rake_task'

  spec_tasks = Dir['spec/*/'].map { |d| File.basename(d) }

  spec_tasks.each do |folder|
    RSpec::Core::RakeTask.new("spec:#{folder}") do |t|
      t.pattern = "./spec/#{folder}/**/*_spec.rb"
      t.rspec_opts = %w(-fs --color)
    end
  end

  task :prepare do
    system 'RACK_ENV=test rake db:reset'
  end

  desc "Run complete application spec suite"
  task spec: [:prepare]
  task spec: spec_tasks.map { |f| "spec:#{f}" }
rescue LoadError
  puts "RSpec is not part of this bundle, skip specs."
end
