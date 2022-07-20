@pokemons.each do |pokemon|
  json.set! pokemon.id do
    json.id pokemon.id
    json.name pokemon.name
    # json.extract! pokemon, :id, :name
    if pokemon.id.between?(1, 125)
      json.image_url asset_path("pokemon_snaps/#{pokemon.image_url}")
    else
      json.image_url pokemon.image_url
    end
  end
end
