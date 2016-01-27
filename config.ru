# This file is used by Rack-based servers to start the application.

if Rails.env.development?
  local_env = YAML.load_file("#{Rails.root}/config/local-env.yml") rescue nil

  if local_env && local_env[Rails.env]
    local_env = local_env[Rails.env]

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
