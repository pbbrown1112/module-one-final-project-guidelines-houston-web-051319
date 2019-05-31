require_relative '../config/environment'

require 'rest-client'
require 'json'
require 'pry'
require 'JSON'


Artist.destroy_all
Location.destroy_all
Concert.destroy_all

# Creating all the best new artists according to Pitchfork

bestNewMusic = [
  {
    "Artist": "Cate Le Bon",
    "Artist_Name": "Cate_Le_Bon",
    "Album": "Reward ",
    "Genre": "Folk/Country"
  },
  {
    "Artist": "Slowthai",
    "Artist_Name": "Slowthai",
    "Album": "Nothing Great About Britain ",
    "Genre": "Rap"
  },
  {
    "Artist": "Jamila Woods",
    "Artist_Name": "Jamila_Woods",
    "Album": "LEGACY! LEGACY! ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Big Thief",
    "Artist_Name": "Big_Thief",
    "Album": "U.F.O.F. ",
    "Genre": "Rock"
  },
  {
    "Artist": "Sunn O))) Experimental Metal  Grayson Haver Currin",
    "Artist_Name": "Sunn_O)))_Experimental_Metal_Grayson_Haver_Currin",
    "Album": "Life Metal ",
    "Genre": "Experimental Metal"
  },
  {
    "Artist": "Beyonce",
    "Artist_Name": "Beyonce",
    "Album": "Homecoming: The Live Album ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Weyes Blood",
    "Artist_Name": "Weyes_Blood",
    "Album": "Titanic Rising ",
    "Genre": "Rock"
  },
  {
    "Artist": "Fennesz",
    "Artist_Name": "Fennesz",
    "Album": "Agora ",
    "Genre": "Experimental"
  },
  {
    "Artist": "Nilufer Yanya",
    "Artist_Name": "Nilufer_Yanya",
    "Album": "Miss Universe ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Chai",
    "Artist_Name": "Chai",
    "Album": "PUNK ",
    "Genre": "Rock"
  },
  {
    "Artist": "RAP",
    "Artist_Name": "RAP",
    "Album": "EXPORT ",
    "Genre": "Experimental"
  },
  {
    "Artist": "Helado Negro",
    "Artist_Name": "Helado_Negro",
    "Album": "This Is How You Smile ",
    "Genre": "Electronic"
  },
  {
    "Artist": "Solange",
    "Artist_Name": "Solange",
    "Album": "When I Get Home ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Nivhek",
    "Artist_Name": "Nivhek",
    "Album": "After its own death / Walking in a spiral towards the house ",
    "Genre": "Electronic Experimental"
  },
  {
    "Artist": "Jessica Pratt",
    "Artist_Name": "Jessica_Pratt",
    "Album": "Quiet Signs ",
    "Genre": "Folk/Country"
  },
  {
    "Artist": "Sharon Van Etten",
    "Artist_Name": "Sharon_Van_Etten",
    "Album": "Remind Me Tomorrow ",
    "Genre": "Rock"
  },
  {
    "Artist": "Jeff Tweedy",
    "Artist_Name": "Jeff_Tweedy",
    "Album": "WARM ",
    "Genre": "Rock"
  },
  {
    "Artist": "Earl Sweatshirt",
    "Artist_Name": "Earl_Sweatshirt",
    "Album": "Some Rap Songs ",
    "Genre": "Rap"
  },
  {
    "Artist": "The 1975",
    "Artist_Name": "The_1975",
    "Album": "A Brief Inquiry Into Online Relationships ",
    "Genre": "Rock"
  },
  {
    "Artist": "Rosalia",
    "Artist_Name": "Rosalia",
    "Album": "El Mal Querer ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "boygenius",
    "Artist_Name": "boygenius",
    "Album": "boygenius EP ",
    "Genre": "Rock"
  },
  {
    "Artist": "Robyn",
    "Artist_Name": "Robyn",
    "Album": "Honey ",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Sheck Wes",
    "Artist_Name": "Sheck_Wes",
    "Album": "MUDBOY ",
    "Genre": "Rap"
  },
  {
    "Artist": "Tim Hecker",
    "Artist_Name": "Tim_Hecker",
    "Album": "Konoyo ",
    "Genre": "Experimental"
  },
  {
    "Artist": "Noname",
    "Artist_Name": "Noname",
    "Album": "Room 25",
    "Genre": "Rap"
  },
  {
    "Artist": "Low",
    "Artist_Name": "Low",
    "Album": "Double Negative",
    "Genre": "Rock"
  },
  {
    "Artist": "Joey Purp",
    "Artist_Name": "Joey_Purp",
    "Album": "QUARTERTHING",
    "Genre": "Rap"
  },
  {
    "Artist": "Yves Tumor",
    "Artist_Name": "Yves_Tumor",
    "Album": "Safe in the Hands of Love",
    "Genre": "Experimental"
  },
  {
    "Artist": "Mitski",
    "Artist_Name": "Mitski",
    "Album": "Be the Cowboy",
    "Genre": "Rock"
  },
  {
    "Artist": "Tirzah",
    "Artist_Name": "Tirzah",
    "Album": "Devotion",
    "Genre": "Experimental"
  },
  {
    "Artist": "The Internet",
    "Artist_Name": "The_Internet",
    "Album": "Hive Mind",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Deafheaven",
    "Artist_Name": "Deafheaven",
    "Album": "Ordinary Corrupt Human Love",
    "Genre": "Metal"
  },
  {
    "Artist": "Let's Eat Grandma",
    "Artist_Name": "Let's_Eat_Grandma",
    "Album": "I��m All Ears",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Kamasi Washington",
    "Artist_Name": "Kamasi_Washington",
    "Album": "Heaven and Earth",
    "Genre": "Jazz"
  },
  {
    "Artist": "Beyonce JAY-Z",
    "Artist_Name": "Beyonce_JAY-Z",
    "Album": "Everything Is Love",
    "Genre": "Pop/R&B Rap"
  },
  {
    "Artist": "SOPHIE",
    "Artist_Name": "SOPHIE",
    "Album": "OIL OF EVERY PEARL��s UN-INSIDES",
    "Genre": "Electronic"
  },
  {
    "Artist": "Tierra Whack",
    "Artist_Name": "Tierra_Whack",
    "Album": "Whack World",
    "Genre": "Rap"
  },
  {
    "Artist": "Snail Mail",
    "Artist_Name": "Snail_Mail",
    "Album": "Lush",
    "Genre": "Rock"
  },
  {
    "Artist": "Father John Misty",
    "Artist_Name": "Father_John_Misty",
    "Album": "God��s Favorite Customer",
    "Genre": "Rock"
  },
  {
    "Artist": "Pusha-T",
    "Artist_Name": "Pusha-T",
    "Album": "Daytona",
    "Genre": "Rap"
  },
  {
    "Artist": "Skee Mask",
    "Artist_Name": "Skee_Mask",
    "Album": "Compro",
    "Genre": "Electronic"
  },
  {
    "Artist": "Playboi Carti",
    "Artist_Name": "Playboi_Carti",
    "Album": "Die Lit",
    "Genre": "Rap"
  },
  {
    "Artist": "Beach House",
    "Artist_Name": "Beach_House",
    "Album": "7",
    "Genre": "Rock"
  },
  {
    "Artist": "Jon Hopkins",
    "Artist_Name": "Jon_Hopkins",
    "Album": "Singularity",
    "Genre": "Electronic"
  },
  {
    "Artist": "Iceage",
    "Artist_Name": "Iceage",
    "Album": "Beyondless",
    "Genre": "Rock"
  },
  {
    "Artist": "DJ Koze",
    "Artist_Name": "DJ_Koze",
    "Album": "Knock Knock",
    "Genre": "Electronic"
  },
  {
    "Artist": "Sleep",
    "Artist_Name": "Sleep",
    "Album": "The Sciences",
    "Genre": "Metal"
  },
  {
    "Artist": "Saba",
    "Artist_Name": "Saba",
    "Album": "CARE FOR ME",
    "Genre": "Rap"
  },
  {
    "Artist": "Kali Uchis",
    "Artist_Name": "Kali_Uchis",
    "Album": "Isolation",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Cardi B",
    "Artist_Name": "Cardi_B",
    "Album": "Invasion of Privacy",
    "Genre": "Rap"
  },
  {
    "Artist": "Jean Grae Quelle Chris",
    "Artist_Name": "Jean_Grae_Quelle_Chris",
    "Album": "Everything��s Fine",
    "Genre": "Rap"
  },
  {
    "Artist": "Kacey Musgraves",
    "Artist_Name": "Kacey_Musgraves",
    "Album": "Golden Hour",
    "Genre": "Folk/Country"
  },
  {
    "Artist": "Amen Dunes",
    "Artist_Name": "Amen_Dunes",
    "Album": "Freedom",
    "Genre": "Rock"
  },
  {
    "Artist": "Mount Eerie",
    "Artist_Name": "Mount_Eerie",
    "Album": "Now Only",
    "Genre": "Rock"
  },
  {
    "Artist": "Soccer Mommy",
    "Artist_Name": "Soccer_Mommy",
    "Album": "Clean",
    "Genre": "Rock"
  },
  {
    "Artist": "A.A.L (Against All Logic)",
    "Artist_Name": "A.A.L_(Against_All_Logic)",
    "Album": "2012 - 2017",
    "Genre": "Electronic"
  },
  {
    "Artist": "SOB X RBE",
    "Artist_Name": "SOB_X_RBE",
    "Album": "Gangin",
    "Genre": "Rap"
  },
  {
    "Artist": "U.S. Girls",
    "Artist_Name": "U.S._Girls",
    "Album": "In a Poem Unlimited",
    "Genre": "Pop/R&B"
  },
  {
    "Artist": "Car Seat Headrest",
    "Artist_Name": "Car_Seat_Headrest",
    "Album": "Twin Fantasy",
    "Genre": "Rock"
  },
  {
    "Artist": "CupcakKe",
    "Artist_Name": "CupcakKe",
    "Album": "Ephorize",
    "Genre": "Rap"
  }
 ]
    
def artists(array)
  album_artists = []
  array.each do | album |
      album_artists << album[:Artist_Name]
  end
  album_artists
end

artists = artists(bestNewMusic)

artists.each do |artist|
  Artist.create(name: artist)
end


# Creating all the Locations
   
# def create_locations(cities_array)
#     cities_array.each do | city |
#         Location.create(city: city[:city], state: city[:state_name])
#     end
# end

# create_locations(cities)

# Creating all the Concerts

def get_events_from_api(name)
  #make the web request
  name1 = name
  artist_link = "https://app.ticketmaster.com/discovery/v2/events.json?keyword=#{name1}&countrycode=US&apikey=ShI4Sd340EJ32f1k6rUgkYPocLSO2qTq"
  response_string = RestClient.get(artist_link)
  response_hash = JSON.parse(response_string)
end
  
def create_concerts

  Artist.all.each do |artist|
    artist_name = artist.name
    begin
      get_events_from_api(artist_name)['_embedded']['events'].each do |event|
        begin 
            event_date = event['dates']['start']['localDate']
            event_time = event['dates']['start']['localTime']
            event_city_name = event['_embedded']['venues'][0]['city']['name']
            event_state_name = event['_embedded']['venues'][0]['state']['name']
            venue_url = event['_embedded']['venues'][0]['url']
            artist_tickets_url = event['_embedded']['attractions'][0]['url']
            new_location = Location.find_or_create_by(city: event_city_name, state: event_state_name)
            Concert.create(name: "#{event_city_name} #{artist_name}", date: event_date, time: event_time, artist_id: artist.id, location_id: new_location.id, venue_url: venue_url, artist_tickets_url: artist_tickets_url)
          rescue
          end    
      end
    rescue
    end
  end
end

create_concerts




