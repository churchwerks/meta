require "bundler/setup"
require "meta"
require_relative '../config/environment'

DB[:conn] = SQLite3::Database.new ":memory:"

RSpec.configure do |config|
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  #you can do global before/after here like this:
  config.before(:each) do
    if Meta.respond_to?(:create_table)
      Meta.create_table
    else
      DB[:conn].execute("DROP TABLE IF EXISTS metas")
      DB[:conn].execute("CREATE TABLE IF NOT EXISTS metas (id INTEGER PRIMARY KEY, name TEXT, something TEXT)")
    end
  end

  config.after(:each) do
      DB[:conn].execute("DROP TABLE IF EXISTS metas")
  end
end
