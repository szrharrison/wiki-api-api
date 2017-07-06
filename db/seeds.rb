# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
account = Account.create_with(password: 'password').find_or_create_by(username: 'admin')
pokeapi = account.api_wikis.find_or_create_by(name:'Pokemon Api')
pokeapi.set_slug
pokeapi.save

####################################################
# Add Pokemon to Pokemon page in Pokemon API       #
####################################################

all_pokemon = pokeapi.pages.create(name: 'pokemon')
all_pokemon.set_slug
all_pokemon.save
(1..100).each do |num|
  pokemon_page = all_pokemon.sub_pages.new( name: num)
  pokemon_page.set_slug

  pokemon = {}
  open("http://pokeapi.co/api/v2/pokemon/#{num}") do |f|
    f.each_line do |line|
      pokemon = JSON.parse(line)
    end
  end
  new_pokemon = pokemon.keys.each_with_object({}) do |key, hash|
    if key != 'game_indices'
      hash[key] = pokemon[key]
    end
  end

  pokemon_page.dataset = Dataset.new(new_pokemon)
  pokemon_page.save
end

####################################################
# Add Types to Type page in Pokemon API            #
####################################################

all_types = pokeapi.pages.create(name: 'type')
all_types.set_slug
all_types.save
(1..18).each do |num|
  type_page = all_types.sub_pages.new( name: num )
  type_page.set_slug

  type = {}
  open("http://pokeapi.co/api/v2/type/#{num}") do |f|
    f.each_line do |line|
      type = JSON.parse(line)
    end
  end

  new_type = type.keys.each_with_object({}) do |key, hash|
    if key != 'names' && key != 'game_indices'
      hash[key] = type[key]
    end
  end

  type_page.dataset = Dataset.new(new_type)
  type_page.save
end

#####################################################
# Add Generations to Generation page in Pokemon API #
#####################################################

all_generations = pokeapi.pages.create(name: 'generation')
all_generations.set_slug
all_generations.save
(1..6).each do |num|
  generation_page = all_generations.sub_pages.new( name: num )
  generation_page.set_slug

  generation = {}
  open("http://pokeapi.co/api/v2/generation/#{num}") do |f|
    f.each_line do |line|
      generation = JSON.parse(line)
    end
  end

  new_generation = generation.keys.each_with_object({}) do |key, hash|
    if key != 'names'
      hash[key] = generation[key]
    end
  end

  generation_page.dataset = Dataset.new(new_generation)
  generation_page.save
end


####################################################
# Add object data_type to subpages in Pokemon API  #
####################################################

pokeapi.pages.all.each do |page|
  page.data_type = 'object'
  page.save
end
