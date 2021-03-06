source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0'
gem 'yard'

gem 'pg'

# Use Haml
gem 'haml'

gem 'bower-rails'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-rails'
gem 'animate-rails', '~> 1.0.8'

gem 'hstore_translate'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
platforms :ruby do # Only linux
  gem 'puma'
end

gem 'exception_notification'
gem 'slack-notifier'
gem 'rubyzip'
gem 'foreman'
gem 'liquid', github: 'ylosix/liquid'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'devise'
gem 'devise-i18n'
gem 'activeadmin', '~> 1.0.0.pre1'
gem 'ckeditor'
gem 'paperclip'

gem 'mailgun_rails'
gem 'newrelic_rpm'
gem 'paper_trail', '~> 4.0.0'

# papertrailapp logs
#gem 'remote_syslog_logger'

# logentries
gem 'le'

# Access an IRB console on exception pages or by using <%= console %> in views
gem 'web-console', group: :development

group :development, :test, :profile do
  gem 'rails-footnotes', '~> 4.0'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'did_you_mean'

  gem 'rails-erd'
  gem 'annotate', github: 'ryanfox1985/annotate_models'

  #profiling
  gem 'bullet'
  gem 'ruby-prof', platforms: :ruby
  gem 'flamegraph'
  gem 'stackprof'
  gem 'rack-mini-profiler', require: false

  # Use debugger (incompatible with Rubymine)
  # gem 'debugger'
  gem 'rubocop'
  gem 'rubycritic', require: false
  gem 'mailcatcher'

  gem 'simplecov'
  gem 'coveralls'
  gem 'codeclimate-test-reporter'

  gem 'awesome_print'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
end
