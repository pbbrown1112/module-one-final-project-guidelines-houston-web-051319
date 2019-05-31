require_relative '../config/environment'

require 'rest-client'
require 'json'
require 'pry'
require 'JSON'

# Get artist names from Artists table
artist_names = Performer.all.map do | artist_obj |
  artist_obj.name
end

prompt = TTY::Prompt.new

def create_performer_variable(select_performer_variable)
  performer_variable = Performer.find_by(name: select_performer_variable)
end

def create_location_variable(select_location_variable)
  location_variable = Location.find_by(city: select_location_variable)
end


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

# The yes and no array

yes = 'Yes'
no = 'No'
yes_no_array = [yes, no]
loop_back_answer = yes
until (loop_back_answer == no)
# You want to find concerts for Pitchfork's Best Music
you_want_pitchfork_music_question = prompt.select("Would you like to select from artists based on Pitchfork's Best New Albums?".colorize(:yellow), yes_no_array)


if you_want_pitchfork_music_question == yes
  user_event = prompt.select('Please select an artist: ', artist_names)

  # p "You have selected #{name}"

  # selection = get_events_from_api(name)
  # selection_events = selection['_embedded']['events']
  # selection_events_names = selection_events.map {|event| event['name']}

  # event = prompt.select('Please select an event: ', selection_events_names)

  # p "You have selected #{event}"

  
else
  
  # Ask the user an event they're interested in
  user_event = prompt.ask("Please enter an event you're interested in:".colorize(:yellow))
  sleep(1)
end
  # Let the user know all events related to their input
  prompt.say("Here are the upcoming events for #{user_event}:".colorize(:yellow))
  sleep(1)

  # Reach out to TicketMaster API
  user_events = get_events_from_api(user_event)
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

  sleep(1)
  prompt_to_purchase = prompt.select("Would you like to buy a ticket:".colorize(:yellow), yes_no_array)
  if prompt_to_purchase == yes
      Launchy.open(artist_tickets_url)
      loop_back_answer = prompt.select('Would you like to search for another event?'.colorize(:yellow), yes_no_array)
  else
      prompt.ask('Why not?'.colorize(:yellow))
      prompt.say('Noted'.colorize(:yellow))
      sleep(1)
      loop_back_answer = prompt.select('Would you like to search for another event?'.colorize(:yellow), yes_no_array)
  end
  sleep(1)

end

# Ask user if they would like to enter Analytics tab of Pitchfork's Best New Music
  analytics_answer = prompt.select('Would you like to explore our Analytics tab'.colorize(:yellow), yes_no_array)
  second_loop_back_answer = yes
  until (second_loop_back_answer == no)

    if analytics_answer = yes
      performer = "Performer"
      event = "Event"
      location = "Location"
  
      class_names = [performer, location, event]
      user_analytics_class_answer = prompt.select('Which class would you like to test'.colorize(:yellow), class_names)

      if user_analytics_class_answer == performer
        performer_or_performers = ["All performers", "Performer"]  
        performer_class_methods = ["most_touring"]
        performer_class_or_instance = prompt.select("Would you like to run analytics on all performers or a specific performer?".colorize(:yellow), performer_or_performers)
          if performer_class_or_instance == "All performers"
            performer_class_method = prompt.select("Select a method to run on all performers:".colorize(:yellow), performer_class_methods)
            if performer_class_method == "most_touring"
              Performer.most_touring
            end
          else
            select_performer_variable = prompt.select('Which Performer would you like to test'.colorize(:yellow), artist_names)
            performer_variable = create_performer_variable(select_performer_variable)
            performer_analytics_methods = ["find_events", "count_events", "find_locations", "count_locations"]
            desired_performer_method = prompt.select('Which method would you like to use:'.colorize(:yellow), performer_analytics_methods)
            if desired_performer_method == "find_events"
              output = performer_variable.find_events
              p output
            elsif desired_performer_method == "count_event"
              output = performer_variable.count_event
              p output
            elsif desired_performer_method == "find_locations"
              output = performer_variable.find_locations
              p output
            elsif desired_performer_method == "count_locations"
              output = performer_variable.count_locations
              p output
            end
          end
        
      elsif user_analytics_class_answer == location
          locations_or_location = ["All locations", "location"]
          class_methods = ["most_happening_location"]
          class_or_instance = prompt.select("Would you like to run analytics on all locations or a specific location?".colorize(:yellow), locations_or_location)
          if class_or_instance == "All locations"
            class_method = prompt.select("Select a method to run on all locations.".colorize(:yellow), class_methods)
            if class_method == "most_happening_location"
              Location.most_happening_location
            end
          else
            location_names = Location.all.map {|location| location.city}
            prompt_location_names = [Location.all, location_names]
            select_location_variable = prompt.select('Which Location would you like to test'.colorize(:yellow), location_names)
            location_variable = create_location_variable(select_location_variable)
            location_analytics_methods = ["find_events", "count_events", "find_performers", "count_performers"]
            desired_location_method = prompt.select('Which method would you like to use:'.colorize(:yellow), location_analytics_methods)
            if desired_location_method == "find_events"
              output = location_variable.find_events
              p output
            elsif desired_location_method == "count_events"
              output = location_variable.count_events
              p output
            elsif desired_location_method == "find_performers"
              output = location_variable.find_performers
              p output
            elsif desired_location_method == "count_performers"
              output = location_variable.count_performers
              p output
            end
          end
        elsif user_analytics_class_answer == event
          event_class_methods = "all events"
            event_class_method = prompt.select("Select a method to run on all events.".colorize(:yellow), event_class_methods)
            if event_class_method == "all events"
              p Event.all.map {|event| event.name}
            end
        end  
        end 
        sleep(1)
        second_loop_back_answer = prompt.select('Would you like to perform another method?'.colorize(:yellow), yes_no_array)
  
      
    end

sleep(1)
prompt.say("Goodbye, #{user_name}.".colorize(:yellow))
