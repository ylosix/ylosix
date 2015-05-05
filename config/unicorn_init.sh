#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage unicorn server
# Description:       Start, stop, restart unicorn server for a specific application.
### END INIT INFO

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/var/www
PID=/home/vagrant/pids/unicorn.pid

if [ -z $RAILS_ENV ]; then
  RAILS_ENV=`cat $APP_ROOT/.ruby-env`
fi

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/rvm/bin:/usr/local/rvm/gems/ruby-2.1.0@ecommerce/bin:/usr/local/rvm/gems/ruby-2.1.0@global/bin:/usr/local/rvm/rubies/ruby-2.1.0/bin
GEM_HOME=/usr/local/rvm/gems/ruby-2.1.0@ecommerce
GEM_PATH=/usr/local/rvm/gems/ruby-2.1.0@ecommerce:/usr/local/rvm/gems/ruby-2.1.0@global
MY_RUBY_HOME=/usr/local/rvm/rubies/ruby-2.1.0
IRBRC=/usr/local/rvm/rubies/ruby-2.1.0/.irbrc
RUBY_VERSION=ruby-2.1.0

SET_PATH="cd $APP_ROOT;"
SET_EXPORTS="export PATH=$PATH; export GEM_PATH=$GEM_PATH; export MY_RUBY_HOME=$MY_RUBY_HOME; export IRBRC=$IRBRC; export RUBY_VERSION=$RUBY_VERSION; export GEM_HOME=$GEM_HOME; export HOME=$APP_ROOT;"
BUNDLE_EXEC="$GEM_HOME/wrappers/bundle exec "

START_UNICORN="$BUNDLE_EXEC $GEM_HOME/bin/unicorn -D -c $APP_ROOT/config/unicorn.rb -E $RAILS_ENV;"
BUNDLE_INSTALL="RAILS_ENV=$RAILS_ENV $GEM_HOME/bin/bundle install;"
RAKE_MIGRATE="RAILS_ENV=$RAILS_ENV $BUNDLE_EXEC $GEM_HOME/wrappers/rake db:migrate;"
COMPILE_ASSETS=""

if [ "$RAILS_ENV" = "production" ]; then
  COMPILE_ASSETS="RAILS_ENV=$RAILS_ENV $BUNDLE_EXEC $GEM_HOME/wrappers/rake assets:precompile;"
fi

RESTART_NGINX="sudo service nginx restart"
CMD="$SET_PATH $SET_EXPORTS $BUNDLE_INSTALL $RAKE_MIGRATE $COMPILE_ASSETS $START_UNICORN"

AS_USER=vagrant

OLD_PIN="$PID.oldbin"

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
  test -s $OLD_PIN && kill -$1 `cat $OLD_PIN`
}

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su - $AS_USER -c "$1"
  fi

  eval $RESTART_NGINX
}

case "$1" in
  start)
    sig 0 && echo >&2 "Already running" && exit 0
    run "$CMD"
    ;;
  stop)
    sig QUIT && exit 0
    echo >&2 "Not running"
    ;;
  force-stop)
    sig TERM && exit 0
    echo >&2 "Not running"
    ;;
  restart|reload)
    sig HUP && echo reloaded OK && exit 0
    echo >&2 "Couldn't reload, starting '$CMD' instead"
    run "$CMD"
    ;;
  upgrade)
    if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
    then
      n=$TIMEOUT
      while test -s $OLD_PIN && test $n -ge 0
      do
        printf '.' && sleep 1 && n=$(( $n - 1 ))
      done
      echo

      if test $n -lt 0 && test -s $OLD_PIN
      then
        echo >&2 "$OLD_PIN still exists after $TIMEOUT seconds"
        exit 1
      fi
      exit 0
    fi
    echo >&2 "Couldn't upgrade, starting '$CMD' instead"
    run "$CMD"
    ;;
  reopen-logs)
    sig USR1
    ;;
  *)
    echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
    exit 1
    ;;
esac

exit 0
