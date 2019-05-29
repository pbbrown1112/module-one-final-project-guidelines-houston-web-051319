require_relative '../config/environment'

require 'rest-client'
require 'json'
require 'pry'
require 'JSON'


puts "sup"

artist_names = Artist.all.map do | artist_obj |
  artist_obj.name
end

prompt = TTY::Prompt.new

name = prompt.select('Please select an artist: ', artist_names)

p "You have selected #{name}"

def get_events_from_api(name)
  #make the web request
  name1 = name
  artist_link = "https://app.ticketmaster.com/discovery/v2/events.json?keyword=#{name1}&countrycode=US&apikey=ShI4Sd340EJ32f1k6rUgkYPocLSO2qTq"
  response_string = RestClient.get(artist_link)
  response_hash = JSON.parse(response_string)
end

selection = get_events_from_api(name)
selection_events = selection['_embedded']['events']
selection_events_names = selection_events.map {|event| event['name']}

event = prompt.select('Please select an event: ', selection_events_names)

p "You have selected #{event}"

Artist.all.each do |artist|
  artist_name = artist.name
  venue_city_name = 0
  venue_state_name = 0
  get_events_from_api(artist_name)['_embedded']['events'].each do |event|
    if !event['_embedded']['venues'][0]['state']
    else
      event_city_name = event['_embedded']['venues'][0]['city']['name']
      event_state_name = event['_embedded']['venues'][0]['state']['name']
      new_location = Location.find_or_create_by(city: event_city_name, state: event_state_name)
      Concert.create(name: "#{event_city_name} #{artist_name}", artist_id: artist.id, location_id: new_location.id)
    end
  end
end






puts "HELLO WORLD"


