desc 'Update rails code and migrate, database, compile assets and restart'
task :update_app do
  puts "##### Environment => #{Rails.env}"

  puts '##### Check github...'
  system "cd #{Rails.root}; git fetch origin; git pull origin;"
  puts '##### Bundle install...'
  system "cd #{Rails.root}; bundle install"
  puts '##### Migrations...'
  system "cd #{Rails.root}; bundle exec rake db:migrate RAILS_ENV=#{Rails.env}"

  if Rails.env.production?
    puts '##### Compile assets...'
    system "cd #{Rails.root}; bundle exec assets:precompile RAILS_ENV=#{Rails.env}"
  end

  puts '##### Restart server...'
  system 'kill -12 `cat /home/vagrant/pids/unicorn.pid`; rm /home/vagrant/pids/unicorn.pid'
  puts '##### Finish!'
end