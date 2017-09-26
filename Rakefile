#require "bundler/gem_tasks"
#require "rspec/core/rake_task"

#RSpec::Core::RakeTask.new(:spec)

#task :default => :spec

require_relative './config/environment.rb'

  def reload!
    load_all './lib/'
  end

  task :console do
    Pry.start
  end
