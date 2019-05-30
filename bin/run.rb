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

def get_events_from_api(name)
  #make the web request
  name1 = name
  artist_link = "https://app.ticketmaster.com/discovery/v2/events.json?keyword=#{name1}&countrycode=US&apikey=ShI4Sd340EJ32f1k6rUgkYPocLSO2qTq"
  response_string = RestClient.get(artist_link)
  response_hash = JSON.parse(response_string)
end

# Welcome message
prompt.say("Welcome to Pitchfork's Best New Music app!".colorize(:yellow))
sleep(1)

# Request user name
user_name = prompt.ask('Please enter your name.', default: 'User')
sleep(1)

# Welcome the user
prompt.say("Hi, #{user_name}!".colorize(:yellow))
sleep(1)

# Ask the user their favorite artist
user_artist = prompt.ask("Please enter an event you're interested in:".colorize(:yellow))
sleep(1)

# Let the user know events for their favorite artist
prompt.say("Here are the upcoming events for #{user_artist}:".colorize(:yellow))
sleep(1)

# Reach out to TicketMaster API
user_events = get_events_from_api(user_artist)
user_list_events = user_events['_embedded']['events']
user_list_event_names = user_list_events.map {|event| event['name']}

# Ask the user to select an event
user_selected_event_name = prompt.select('Please select an event: ', user_list_event_names)
user_selected_event = user_list_events.find {|event| event['name'] == user_selected_event_name}

# Process TicketMaster API
if !user_selected_event['_embedded']['venues'][0]['state']
else
  event_date = user_selected_event['dates']['start']['localDate']
  event_time = user_selected_event['dates']['start']['localTime']
  event_city_name = user_selected_event['_embedded']['venues'][0]['city']['name']
  event_state_name = user_selected_event['_embedded']['venues'][0]['state']['name']
  venue_name = user_selected_event['_embedded']['venues'][0]['name']
  venue_url = user_selected_event['_embedded']['venues'][0]['url']
  artist_tickets_url = user_selected_event['_embedded']['attractions'][0]['url']
end

prompt.say("You have selected #{user_selected_event_name}".colorize(:yellow))
sleep(1)

# Let the user know event info
prompt.say("#{user_selected_event_name} is at #{venue_name} on #{event_date} at #{event_time} in #{event_city_name}, #{event_state_name}.".colorize(:yellow))
yes = 'Yes'
no = 'No'
yes_no_array = [yes, no]
sleep(1)
prompt_to_purchase = prompt.select("Would you like to buy a ticket:".colorize(:yellow), yes_no_array)
if prompt_to_purchase == yes
    Launchy.open(artist_tickets_url)
else
    prompt.ask('Why not?'.colorize(:yellow))
    prompt.say('Noted'.colorize(:yellow))
end
sleep(1)
you_want_pitchfork_music_question = prompt.select("Would you like to select from artists based on Pitchfork's Best New Albums?".colorize(:yellow), yes_no_array)



# name = prompt.select('Please select an artist: ', artist_names)

# p "You have selected #{name}"

# selection = get_events_from_api(name)
# selection_events = selection['_embedded']['events']
# selection_events_names = selection_events.map {|event| event['name']}

# event = prompt.select('Please select an event: ', selection_events_names)

# p "You have selected #{event}"




