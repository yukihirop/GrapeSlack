require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  desc 'Rescue setup'
  task setup: :environment do
    require 'resque'
    require 'resque-scheduler'
  end
end