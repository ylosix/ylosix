desc 'Update rails code and migrate, database, compile assets and restart'
task :update_app do
  file_environment = "#{Rails.root}/.ruby-env"

  environment = 'production'
  environment = File.read(file_environment).strip if File.exist? file_environment

  puts "##### Check github... env => #{environment}"
  system "cd #{Rails.root}; git fetch origin; git pull origin;"

  bundle_args = '--without development test'
  bundle_args = '--without production' if environment == 'development'
  puts "##### Bundle install... env => #{bundle_args}"
  system "cd #{Rails.root}; bundle install #{bundle_args}"

  rake_args = File.read('.env').split.join(' ')
  puts "##### Migrations... env => #{rake_args}"
  system "cd #{Rails.root}; bundle exec rake db:migrate #{rake_args}"

  if environment == 'production'
    puts "##### Compile assets... env => #{rake_args}"
    system "cd #{Rails.root}; bundle exec rake assets:precompile #{rake_args}"
  end

  puts "##### Restart server... env => #{environment}"
  system 'sudo stop ecommerce'
  system 'sudo start ecommerce'
  puts "##### Finish!!! env => #{environment}"
end