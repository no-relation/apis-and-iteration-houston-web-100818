require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  films_array = []
  response_hash["results"].each do |person|

    if person["name"] == character
      person["films"].map do |film_url|
        to_be_parsed = RestClient.get(film_url)
        episode_hash = JSON.parse(to_be_parsed)
        films_array << episode_hash
      end
    end
  end
  # NOTE: in this demonstration we name many of the variables _hash or _array. 
  # This is done for educational purposes. This is not typically done in code.


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  films_array.sort_by do |film|
    film["episode_id"]
  end
end

def print_movies(films_hash)
  films_hash.each do |film|
    puts "Episode #{film["episode_id"]}"
    puts "#{film["title"]}"
    puts "Directed by #{film["director"]}"
    puts "Produced by #{film["producer"]}"
    puts "Released #{film["release_date"]}"
    puts "\n"

  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end
#show_character_movies("Luke Skywalker")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
