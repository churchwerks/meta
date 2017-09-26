#require "meta/version"

#module Meta
  # Your code goes here...
#end
class Meta
  attr_accessor :id, :name, :something

  def initialize(id: nil, name:, something:)
    @id = id
    @name = name
    @something = something
  end

  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.create_table
    self.drop_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS #{self.table_name} (
      id INTEGER PRIMARY KEY,
      name TEXT,
      something TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS metas
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id
      update
    else
      sql = <<-SQL
        INSERT INTO metas (name, something)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.something)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM metas")[0][0]
      end
    self
  end

  def update()
    sql = "UPDATE metas SET name = ?, something = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.something, self.id)
  end

  def self.create(name:, something:)
    meta = meta.new(name: name, something: something)
    meta.save
    meta
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    something = row[2]
    self.new(id: id, name: name, something: something)
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT *
      FROM metas
      WHERE id = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql,id).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.find_or_create_by(name:, something:)
   meta = DB[:conn].execute("SELECT * FROM metas WHERE name = '#{name}' AND something = '#{something}'")
   if !meta.empty?
     meta_data = meta[0]
     meta = meta.new(id: meta_data[0], name: meta_data[1], something: meta_data[2])
   else
     meta = self.create(name: name, something: something)
   end
   meta
 end

 def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM metas
      WHERE name = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql,name).map do |row|
      self.new_from_db(row)
    end.first
  end

end
