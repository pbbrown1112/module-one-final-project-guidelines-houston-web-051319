
class Performer < ActiveRecord::Base
    has_many :events
    has_many :locations, through: :events 

    def find_events
      self.events.uniq.map {|event| event.name}
    end

    def count_events
      self.find_events.length
    end

    def find_locations
      self.locations.uniq.map {|location| location.city}
    end

    def count_locations
      self.find_locations.length
    end

    def self.most_touring
      most_touring_performer = Performer.all[0]
      Performer.all.each do |performer|
        if performer.count_events > most_touring_performer.count_events 
          most_touring_performer = performer
        end
      end
      p "#{most_touring_performer.name} is most touring performer with: #{most_touring_performer.count_events}"
    end

    def events_by_location(location)
      desired_location_id = Location.all.find_by(city: location)
      desired_locations = self.events.select do |event|
        event.location_id == desired_location_id.id
      end
      desired_locations 
    end

end

beach_house = Performer.find_by(name: "Beach_House")

