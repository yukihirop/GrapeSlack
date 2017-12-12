# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

set :host, ENV['GRAPESLACK_HOST']
role :app, %W{ grape-slack@#{fetch(:host)} }
role :web, %W{ grape-slack@#{fetch(:host)} }
role :db,  %W{ grape-slack@#{fetch(:host)} }, primary: true
# https://stackoverflow.com/questions/29471439/capistrano-resque-error-with-remote-redis-db
# このroleを追加しないと、SocketError (getaddrinfo: Name or service not known)
# redis://...のようなホストでtcpで接続しようとしてエラー
role :resque_worker, %W{ grape-slack@#{fetch(:host)} }

server fetch(:host), user: 'grape-slack', roles: %w{web app db resque_worker}

# この設定がないと、デプロイ先でdb:migrateされない
set :migration_role, 'db'
# 毎回、db:migrateされるのを避ける
set :conditionally_migrate, fetch(:conditionally_migrate, false)

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
