# config valid only for current version of Capistrano
lock '3.9.0'

set :default_env, {
  SLACK_API_KEY: ENV['SLACK_API_KEY'],
  SLACK_API_SECRET: ENV['SLACK_API_SECRET'],
  SLACK_API_TOKEN: ENV['SLACK_API_TOKEN'],
  DEVISE_KEY_BASE: ENV['DEVISE_KEY_BASE'],
  SECRET_KEY_BASE: ENV['SECRET_KEY_BASE'],
  GRAPESLACK_DATABASE_PASSWORD: ENV['GRAPESLACK_DATABASE_PASSWORD'],
  GRAPESLACK_DATABASE_HOST: ENV['GRAPESLACK_DATABASE_HOST'],
  GRAPESLACK_REDIS_HOST: ENV['GRAPESLACK_REDIS_HOST'],
  GRAPESLACK_HOST: ENV['GRAPESLACK_HOST']
}

set :application, 'GrapeSlack'
set :repo_url, 'git@github.com:yukihirop/GrapeSlack.git'

# appインスタンスからgithubにssh接続するために必要
# localのid_rsaを使って、forward_agentで繋いでいる。
set :ssh_options, {
  # capistranoコマンド実行者の秘密鍵
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/GrapeSlack'

# logを詳細表示
set :format, :pretty
set :log_level, :debug
# ssh -tで実行
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', '.envrc'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle'

# Default value for keep_releases is 5
set :keep_releases, 5

# rubyの設定
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
# rbenv_path use $HOME/.rbenv by default
# http://nograve.hatenadiary.jp/entry/2015/10/19/155508
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# bundlerのジョブ数
set :bundle_jobs, 4

# Gemfileの場所
set :bundle_gemfile,  "Gemfile"

# unicornの設定
# set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

# rakeをbundle exec rakeにしてくれる設定
SSHKit.config.command_map[:rake] = 'bundle exec rake'

namespace :deploy do

  # 上記linked_filesで使用するファイルをアップロードするタスク
  desc 'Upload database.yml & secrets.yml & .envrc'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "sudo mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end

  # gem bundle install
  desc 'gem install bundler'
  task :bundle do
    on roles(:app) do |host|
      execute "#{fetch(:rbenv_path)}/bin/rbenv exec gem install bundler"
    end
  end

  # redis-serverをデーモン起動
  desc 'redis-server start demonize'
  task :redis_server do
    on roles(:app) do |host|
      execute '/usr/local/bin/redis-server /etc/redis/redis.conf'
    end
  end

  # unicorn再起動
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end

# namespace :redis do
#   %w[start stop restart].map do |cmd|
#     desc "#{cmd}s redis-server"
#     task cmd, :roles => :app do
#       run "#{sudo} /etc/init.d/redis-server #{cmd}"
#     end
#   end
# end

#before 'deploy:check', 'deploy:bundle'

# db:migrateの前にdb:createが走るようになる
before 'deploy:migrate', 'deploy:db:create'
# linked_filesで使用するファイルをアップロードするタスクは、deployが行われる前に実行する必要がある
before 'deploy:starting', 'deploy:upload'

# Capistrano 3.1.0からデフォルトで deploy:restart タスクが呼ばれなくなったので
after 'deploy:publishing', 'deploy:restart'

after 'deploy:finished', 'deploy:redis_server'
after 'deploy:redis_server', 'resque:restart'
