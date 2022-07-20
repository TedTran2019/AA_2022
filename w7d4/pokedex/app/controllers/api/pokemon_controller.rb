class Api::PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render :index
  end
  
  def show
    @pokemon = Pokemon.find(params[:id])
    render :show
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      PokeMove.create!(pokemon_id: @pokemon.id, move_id: 1)
      PokeMove.create!(pokemon_id: @pokemon.id, move_id: 2)
      move1 = Move.find_or_create_by(name: params[:move_one])
      move2 = Move.find_or_create_by(name: params[:move_two])
      PokeMove.create!(pokemon_id: @pokemon.id, move_id: move1.id)
      PokeMove.create!(pokemon_id: @pokemon.id, move_id: move2.id)
      render :show
    else
      render json: @pokemon.errors.full_messages, status: 422
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :attack, :defense, :poke_type, :image_url)
  end
end
