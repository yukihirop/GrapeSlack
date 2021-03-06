source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'omniauth-slack'
gem 'devise', git: 'https://github.com/gogovan/devise.git', branch: 'rails-5.1'

gem 'rails-i18n'

gem 'slack-api'
gem 'activerecord-import'
gem 'resque'
gem 'resque-scheduler'
gem 'redis-objects'
gem 'redis-namespace'

gem 'foreman'
gem 'config'

# bootstrap
gem 'less-rails', git: 'https://github.com/MustafaZain/less-rails'
gem 'therubyracer'
gem 'execjs'
gem 'twitter-bootstrap-rails'

gem 'kaminari'
gem 'listen', '>= 3.0.5', '< 3.2'

# deplayツール
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-rbenv'
gem 'capistrano-resque', '0.2.1', require: false # cf) https://github.com/sshingler/capistrano-resque/issues/101
gem 'capistrano-rails-db'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13.0'
  gem 'capybara-webkit', '~> 1.14.0'
  gem 'selenium-webdriver'

  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing', require: false

  gem 'seed-fu'
  gem 'rails-erd'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'bcrypt-ruby'

  gem 'gimei'
  gem 'ffaker'

  gem 'i18n-tasks'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'rubocop', require: false
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'shoulda-matchers'
  # HTTP requests用のモックアップを作ってくれる
  gem 'webmock'
  gem 'vcr'
  gem 'mock_redis'
end

group :production do
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
