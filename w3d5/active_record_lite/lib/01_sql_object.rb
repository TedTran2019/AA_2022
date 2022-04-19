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
    results.map { |hash| self.new(hash) }
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

    self.new(data.first)
  end

  def initialize(params = {})
    params.each do |col, value|
      col = col.to_sym
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
    columns = self.class.columns.drop(1)
    col_names = columns.join(',')
    question_marks = ('?' * columns.length).split('').join(',')
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
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
    self.id.nil? ? insert : update
  end
end
