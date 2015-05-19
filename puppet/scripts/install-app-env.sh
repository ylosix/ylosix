#!/bin/bash
APP_PATH=/var/www
RVM_PATH=/usr/local/rvm
RVM_WRAPPERS_PATH=/usr/local/rvm/wrappers/ruby-2.1.6@ecommerce
RVM_SUDO_PATH=/usr/local/rvm/bin/rvmsudo

RAILS_ENV=$1
DATABASE_URL=postgres://ecommerce_user:ecommerce_pass@localhost:5432/ecommerce

if [ -z $RAILS_ENV ]; then
  RAILS_ENV=development
fi

# Set permisions
su -c "chmod 775 $APP_PATH"

su -c "chown -R www-data:www-data $APP_PATH"
su -c "chmod -R g+w $APP_PATH"

# Create environment
su - vagrant -c "cd $APP_PATH; echo \"2.1.6\" > .ruby-version"
su - vagrant -c "cd $APP_PATH; echo \"ecommerce\" > .ruby-gemset"
su - vagrant -c "cd $APP_PATH; echo $RAILS_ENV > .ruby-env"

database=sqlite
if [ "$RAILS_ENV" == "production" ]; then
  database=postgresql
fi

su - vagrant -c "cd $APP_PATH; echo 'RAILS_ENV=$RAILS_ENV' > .env"
su - vagrant -c "cd $APP_PATH; echo 'RAILS_DB=$database' >> .env"
su - vagrant -c "cd $APP_PATH; echo 'PORT=3000' >> .env"
su - vagrant -c "cd $APP_PATH; echo 'GEM_PATH=$RVM_PATH/gems/ruby-2.1.6@ecommerce' >> .env"
su - vagrant -c "cd $APP_PATH; echo 'PATH=$RVM_PATH/wrappers/ruby-2.1.6@ecommerce:$RVM_PATH/gems/ruby-2.1.6/bin:$RVM_PATH/rubies/ruby-2.1.6/bin:/home/user/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$RVM_PATH/bin' >> .env"
su - vagrant -c "cd $APP_PATH; echo 'RAILS_PIDS=/home/vagrant/pids/rails_server.pid' >> .env"
su - vagrant -c "cd $APP_PATH; echo 'RAILS_LOGS=/home/vagrant/logs/rails_server.log' >> .env"

#Setup project
su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/gem install bundler"

#clean shit
#TODO check if exist folders
su - vagrant -c "cd $APP_PATH; rm .bundle/config"
su - vagrant -c "cd $APP_PATH; rm -R public/assets"
su - vagrant -c "cd $APP_PATH; rm -R public/ckeditor_assets"
su - vagrant -c "cd $APP_PATH; rm -R public/system"
su - vagrant -c "cd $APP_PATH; rm db/*.sqlite3"

if [ "$RAILS_ENV" == "production" ]; then
  su - vagrant -c "cd $APP_PATH; echo 'DATABASE_URL=$DATABASE_URL' >> .env"
  su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/bundle install --without development test"
else
  su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/bundle install --without production"
fi

if [ -z $SECRET_KEY_BASE ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/rake secret RAILS_ENV=$RAILS_ENV > .ruby-secret"
  SECRET_KEY_BASE=`cat $APP_PATH/.ruby-secret`
  su - vagrant -c "cd $APP_PATH; echo 'SECRET_KEY_BASE=$SECRET_KEY_BASE' >> .env"
fi

if [ "$RAILS_ENV" == "production" ]; then
  project_parameters=`echo " RAILS_ENV=$RAILS_ENV SECRET_KEY_BASE=$SECRET_KEY_BASE RAILS_DB=$database DATABASE_URL=$DATABASE_URL "`
else
  project_parameters=`echo " RAILS_ENV=$RAILS_ENV SECRET_KEY_BASE=$SECRET_KEY_BASE RAILS_DB=$database "`
  su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/rake db:create $project_parameters"
fi

su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/rake db:migrate $project_parameters"
su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/rake db:seed $project_parameters"

if [ "$RAILS_ENV" == "production" ]; then
  su - vagrant -c "cd $APP_PATH; $RVM_WRAPPERS_PATH/rake assets:precompile $project_parameters"
  su - vagrant -c "cd $APP_PATH; sed -i 's/git@github.com:devcows\/ecommerce.git/https:\/\/github.com\/devcows\/ecommerce.git/g' .git/config"
fi


# Set foreman file
# For install nginx + unicorn
#su - vagrant -c "echo 'web: $RVM_WRAPPERS_PATH/bundle exec unicorn -c $APP_PATH/config/unicorn.rb -E $RAILS_ENV' > $APP_PATH/Procfile"
#su - vagrant -c "echo 'nginx: sudo /usr/sbin/nginx -c /etc/nginx/nginx.conf' >> $APP_PATH/Procfile"
su - vagrant -c "cd $APP_PATH; $RVM_SUDO_PATH $RVM_WRAPPERS_PATH/bundle exec foreman export upstart --app=ecommerce --user=vagrant /etc/init"
su -c "start ecommerce"

# localhost port 80 to 3000
su -c "iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 3000"

# external port 80 to 3000
su -c "iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000"

# TODO IPTABLES PERSISTENT