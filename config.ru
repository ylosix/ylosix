# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

if Rails.env.profile?
  Dir.mkdir("#{Rails.root}/tmp/profile") unless File.exist?("#{Rails.root}/tmp/profile")
  use Rack::RubyProf, path: "#{Rails.root}/tmp/profile"
end

run Rails.application
