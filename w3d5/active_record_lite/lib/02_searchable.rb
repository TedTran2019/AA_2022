require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    find = params.keys.map { |key| "#{key} = ?"}.join(' AND ')
    data = DBConnection.execute(<<-SQL, *(params.values))
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{find}
    SQL

    data.map { |datum| self.new(datum) }
  end
end

class SQLObject
  extend Searchable
end
