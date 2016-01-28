# This file is used by Rack-based servers to start the application.

if ENV['RAILS_ENV'] != 'production'
  local_env_config = File.expand_path('../config/local-env.yml', __FILE__)
  local_env = YAML.load_file(local_env_config) if File.exist?(local_env_config)
  current_env = ENV['RAILS_ENV']

  if local_env && local_env[current_env]
    local_env = local_env[current_env]

    if local_env.class == Hash
      local_env.each do |key, value|
        ENV[key] = value
      end
    end
  end
end

require ::File.expand_path('../config/environment', __FILE__)

if Rails.env.profile?
  Dir.mkdir("#{Rails.root}/tmp/profile") unless File.exist?("#{Rails.root}/tmp/profile")
  use Rack::RubyProf, path: "#{Rails.root}/tmp/profile"
end

run Rails.application
