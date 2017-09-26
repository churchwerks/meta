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

  task :scrape_metas do
    topic_scraper = MetaScraper.new("http://biblestudytools.com/topical-verses/")
    #topic_scraper.call
    #verse_scraper = MetaScraper.new('http://biblestudytools.com/topical-verses/peace-bible-verses/')
    #verse_scraper.call
  end
