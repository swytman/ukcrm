set :application, 'ukcrm.ru'
set :repo_url, 'https://github.com/swytman/ukcrm.git'
set :deploy_to, '/var/www/ukcrm'
# set :rollbar_token, 'e91415aea6404844afe7f709d62a76b5'
# set :rollbar_env, Proc.new { fetch :stage }
# set :rollbar_role, Proc.new { :app }
set :current_path,  "#{fetch(:deploy_to)}/current"
set :unicorn_conf, "#{fetch(:deploy_to)}/conccurrent/config/unicorn/#{fetch(:stage)}.rb"
set :unicorn_pid, "#{fetch(:deploy_to)}/shared/pids/unicorn.pid"
set :linked_files, %w{config/secrets.yml config/database.yml config/mail.yml}
set :linked_dirs, %w{public/system}

# UNICORN


#NGINX
namespace :nginx do
  task :restart do
    on roles(:web) do
      execute "sudo service nginx restart"
    end
  end
  task :start do
    on roles(:web) do
      execute "sudo service nginx start"
    end
  end
  task :stop do
    on roles(:web) do
      execute "sudo service nginx stop"
    end
  end

end

# DB
namespace :db do
  task :migrate do
    on roles(:db) do
      execute "rake db:migrate RAILS_ENV=#{fetch(:rails_env)} --trace"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end