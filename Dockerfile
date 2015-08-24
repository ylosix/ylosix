FROM ruby:2.1.6
MAINTAINER ryanfox1985 <wolf.fox1985@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update and upgrade
RUN apt-get -q update
RUN apt-get -qy upgrade

# Install packages
RUN apt-get install -qy build-essential libpq-dev libmysqlclient-dev nodejs git-core

ENV APP_HOME /var/www
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*