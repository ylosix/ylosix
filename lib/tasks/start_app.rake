desc 'Start app'
task :start_app do
  puts "##### Environment => #{Rails.env}"

  puts '##### Start foreman...'
  system "cd #{Rails.root}; foreman start -f Procfile"
end