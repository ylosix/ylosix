namespace :db do
  desc 'Generate demo commerce'
  task :gen_demo => :environment do
    Rake::Task['db:seed'].invoke
    Rake::Task['db:gen_demo_users'].invoke
    Rake::Task['db:gen_demo_categories'].invoke
    Rake::Task['db:gen_demo_tags'].invoke
    Rake::Task['db:gen_demo_taxes'].invoke
    Rake::Task['db:gen_demo_products'].invoke
    Rake::Task['db:gen_demo_shopping_carts'].invoke
    Rake::Task['db:gen_demo_shopping_orders'].invoke
  end
end