namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo => :environment do
    puts '####################'
    puts '## Invoking seed'
    puts '####################'
    Rake::Task['db:seed'].invoke

    puts '####################'
    puts '## Other tasks'
    puts '####################'
    Rake::Task['db:gen_demo_users'].invoke
    Rake::Task['db:gen_demo_categories'].invoke
    Rake::Task['db:gen_demo_tags'].invoke
    Rake::Task['db:gen_demo_taxes'].invoke
    Rake::Task['db:gen_demo_products'].invoke
    Rake::Task['db:gen_demo_shopping_carts'].invoke
    Rake::Task['db:gen_demo_shopping_orders'].invoke
    Rake::Task['db:gen_demo_carriers'].invoke
  end
end