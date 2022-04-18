class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    data = Seed.find_by_sql ["
    SELECT
      seeds.*
    FROM
      houses
    JOIN
      gardeners ON houses.id = gardeners.house_id
    JOIN
      plants ON gardeners.id = plants.gardener_id
    JOIN
      seeds ON plants.id = seeds.plant_id
    WHERE
      houses.id = ?
    ", id]
    data
  end
end
