require 'bundler'
Bundler.require

require_relative '../lib/meta'
require_relative '../lib/meta_scraper'
require 'sqlite3'
require 'pry'
require 'rake'
require 'nokogiri'
require 'open-uri'

require_all 'lib'

DB = {:conn => SQLite3::Database.new("db/metas.db")}
