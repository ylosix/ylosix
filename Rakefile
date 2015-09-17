# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically
# be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  require 'yard'
  require 'yard/rake/yardoc_task'
  desc 'Generate documentation for the wice_grid plugin.'
  YARD::Rake::YardocTask.new(:rdoc) do |t|
    t.files   = %w(lib/**/*.rake app/**/*.rb)
    t.options = %w(--main=README.md --file LICENSE)
    t.stats_options = ['--list-undoc']
  end
end
