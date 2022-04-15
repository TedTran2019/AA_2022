# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
        GROUP BY
          continent
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT
    continent, name, area
  FROM
    countries
  WHERE
    area = (
      SELECT
        MAX(countries_max.area)
      FROM
        countries AS countries_max
      WHERE
        countries.continent = countries_max.continent
      GROUP BY
        countries_max.continent
    )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  SELECT
    name, continent
  FROM
    countries
  WHERE
    population > (
      SELECT
       (3 * countries_large.population) AS triple_pop
      FROM
        countries AS countries_large
      WHERE
        countries.continent = countries_large.continent
      ORDER BY
        countries_large.population desc
      LIMIT 1
      OFFSET 1
    )
  SQL
end
