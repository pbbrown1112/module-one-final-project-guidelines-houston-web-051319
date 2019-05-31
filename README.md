# Pitchfork's Best New Music

# User stories

* As a user, I want to enter event and/or location and find events
* As a user, I want to scroll through Pitchfork's Best New Music artists and find their events
* As a user, I want to be directed to a link where I can purchase event tickets
* As a user, I want to be able to analyze event data based on Pitchfork's Best New Music artists

# Running app

This app is CLI-based and run in the console. Start the app by running the bin/run.rb file.
 
Once the app is started the user will be prompted to enter their name. Then the prompt will ask if the user would like to select from artists based on Pitchfork's Best New Albums.
 
If the user answers yes, they can select one artist from a prompt list. Upon artist selection the user can choose from a list of upcoming events by their selected artist. Upon event selection the console displays event info including name, venue, date, time, and location. Then the prompt will ask if the user would like to buy a ticket based on the displayed event info. If the user answers yes, CLI will open internet browser directly to a TicketMaster purchase link for the chosen event.  If the user answers no, then the CLI will ask for optional feedback detailing why the user passed on TicketMaster service. After "noting" user's feedback, CLI will prompt if the user is interested in any other event, and loop back to the "search event" step.

If the user answers no, CLI prompt will ask the user to enter an event they are interested in. The CLI would then search TicketMaster API for asked events and list possible matches. The user would then be able to select their desired event. Upon event selection the console displays event info including name, venue, date, time, and location. Then the prompt will ask if the user would like to buy a ticket based on the displayed event info. If the user answers yes, CLI will open internet browser directly to a TicketMaster purchase link for the chosen event. If the user answers no, then the CLI will ask for optional feedback detailing why the user passed on TicketMaster service. After "noting" user's feedback, CLI will prompt if the user is interested in any other event, and loop back to the "search event" step.

# Seeding Database with Top Artists (According to Pitchfork)

The app uses Pitchfork's Top Album list to prepopulate the database with the top 60 trending artists. We used a data-miner tool (from data-miner.io) to scrape data from Pitchfork's website, pull data in CSV formate, and then convert the CSV to a JSON file using "convertcsv.com". We input the JSON file to seeds.rb from where we create our SQL database. The "Performer" database is a variable source table and can be adjusted according to user's preference and events/performers the user would like to view. 

# Seeding Database with Concerts and Locations where Top Artists are performing

This app utilizes the TicketMaster API. The seeds file runs every "Performer" (in our case Pitchfork's top Artists) from our Performers table through the TicketMaster API search. The TicketMaster API returns the events for each artist and each artist's event's JSON file is parsed so the event data can be utilized. Once the event is in appropriate (database) format, the seed file creates a new entry for each unique Location and Event. 

After setting up three databases (Performers, Locations and join class Events), user can choose to run through the CLI and purchase tickets for desired events or use proprietary analytics tab to process data from Ticketmaster API. 

Some of the data-processing methods available to the user are:

  <b>Performer Methods<b>
 
  1) find_events -- Listing all upcoming Events for selected Performer
  2) find_locations -- Listing all Locations for Events by selected Performer 
  3) count_events -- Counting all upcoming Events for selected Performer
  4) count_locations -- Counting all Locations for Events by selected Performer
  5) self.most_touring -- Showing Performer with the most events
  6) events_by_location(location) -- Find Events in specified Location with selected Performer. Take one location argument.

  <b>Location Methods<b>
 
  1) find_events -- Listing all upcoming Events for selected Location
  2) find_performers -- Listing all Performers by selected Location 
  3) count_events -- Counting all upcoming Events for selected Location
  4) count_performers -- Counting all Performers for Events by selected Location 
  5) self.most_happening_location -- Showing Location with the most events
  6) events_by_performer -- Find Events with specified Performer by selected Location. Takes one performer argument.

   <b>Event Methods<b>
 
  1) all_events -- Listing all events 
 

 ## Authors
 
  Brendan Brown and Stefan Stojanovic
 