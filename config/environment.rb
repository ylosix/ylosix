if ENV['RAILS_ENV'] != 'production'
  local_env_config = File.expand_path('../local-env.yml', __FILE__)
  require 'yaml'
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

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
