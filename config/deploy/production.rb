set :stage, :production
set :rails_env, 'production'

set :rvm_ruby_version, '2.4.1'

server '198.199.109.47', user: 'swytman', port: 17768, roles: %w{web app db}

