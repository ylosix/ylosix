FROM ruby:2.1.6
MAINTAINER ryanfox1985 <wolf.fox1985@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update and upgrade
RUN apt-get -q update
RUN apt-get -qy upgrade

# Install packages
RUN apt-get install -qy build-essential libpq-dev nodejs git-core

ENV APP_HOME /var/www
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN git clone https://github.com/ylosix/ylosix.git $APP_HOME
RUN mv config/database.yml.docker config/database.yml
RUN mv config/secrets.yml.docker config/secrets.yml

# Bundle install
RUN bundle install --without development test profile

# SECRET KEY BASE
RUN export SECRET_KEY_BASE=`rake secret RAILS_ENV=production`
RUN sed -i "s/SECRET_KEY_BASE_TOKEN/$SECRET_KEY_BASE/g" config/secrets.yml

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
