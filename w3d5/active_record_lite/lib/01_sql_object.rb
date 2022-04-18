require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.
require 'byebug'
class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    .first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) {
        self.attributes[column]
      }
      define_method("#{column}=") { |value|
        self.attributes[column] = value
      }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
    table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
    @table_name
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map do |hash|
      sym_hash = {}
      hash.each { |k, v| sym_hash[k.to_sym] = v}
      self.new(sym_hash)
    end
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    return nil if data.empty?

    data_sym = {}
    data.first.each { |k, v| data_sym[k.to_sym] = v }
    self.new(data_sym)
  end

  def initialize(params = {})
    params.each do |col, value|
      raise "unknown attribute '#{col}'" unless self.class.columns.include?(col)

      send("#{col}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| send(col)}
  end

  def insert
    col_names = self.class.columns.join(',')
    question_marks = ('?' * self.class.columns.length).split('').join(',')
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.map { |col| "#{col} = ?"}.join(',')
    DBConnection.execute(<<-SQL, *attribute_values, self.id)
    UPDATE
      #{self.class.table_name}
    SET
    #{col_names}
    WHERE
      id = ?
    SQL
  end

  def save
    # ...
  end
end
