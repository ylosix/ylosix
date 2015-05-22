# Annotate models
task :annotate do
  puts 'Annotating models...'
  system 'bundle exec annotate'
end

# Run annotate task after db:migrate
#  and db:rollback tasks
if Rails.env.development?

  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults({
                              show_indexes: true,
                              show_foreign_keys: true,
                              simple_indexes: false,
                              require: '',
                              exclude_tests: false,
                              exclude_fixtures: false,
                              exclude_factories: false,
                              ignore_model_sub_dir: false,
                              skip_on_db_migrate: false,
                              format_bare: true,
                              format_rdoc: false,
                              format_markdown: false,
                              sort: false,
                              force: false,
                              trace: false,
                          })
  end

  Annotate.load_tasks

  Rake::Task['db:migrate'].enhance do
    Rake::Task['annotate'].invoke
    Rake::Task['generate_erd'].invoke
  end

  Rake::Task['db:rollback'].enhance do
    Rake::Task['annotate'].invoke
    Rake::Task['generate_erd'].invoke
  end
end