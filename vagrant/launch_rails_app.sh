export RAILS_ENV=development
export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce

rm -rf /usr/local/bundle/config

cd /vagrant
rvm ruby-2.3.0@development
bundle install
bundle exec rake db:create db:schema:load db:gen_demo
bundle exec rake db:migrate
#bundle exec puma -C config/puma.rb
