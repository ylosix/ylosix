FROM ruby:2.2.3
MAINTAINER ryanfox1985 <wolf.fox1985@gmail.com>

# Update and upgrade
RUN apt-get -q update
RUN apt-get -qy upgrade

# Install packages
RUN apt-get install -qy build-essential libpq-dev nodejs git-core graphviz tree imagemagick

ENV APP_HOME /var/www
ENV RAILS_ENV production
ENV SECRET_KEY_BASE 3480d0e7ea53d0c1fadf6fd7a1686dee8c453bb5b4b8602f691cbc2399b0db0d25bc7515590e0dde6cbabe3f8070f0620b654a5f10e7f0d10d376245b95a36ef

# Prepare folders
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile      $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

# Install gems
RUN bundle install --without development test profile

# Add the rails app
COPY . $APP_HOME

# Compile assets
RUN rake assets:precompile

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]