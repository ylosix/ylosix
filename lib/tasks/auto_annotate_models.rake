# Annotate models
task :annotate do
  puts 'Annotating models...'
  system 'bundle exec annotate'
end

# Run annotate task after db:migrate
#  and db:rollback tasks
if Rails.env.development?
  Rake::Task['db:migrate'].enhance do
    Rake::Task['annotate'].invoke
    Rake::Task['generate_erd'].invoke
  end

  Rake::Task['db:rollback'].enhance do
    Rake::Task['annotate'].invoke
    Rake::Task['generate_erd'].invoke
  end
end