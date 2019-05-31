class Location < ActiveRecord::Base
  has_many :events
  has_many :performers, through: :events

    def find_events
      self.events.uniq.map {|event| event.name}
    end

    def count_events
      self.find_events.length
    end

    def find_performers
      self.performers.uniq.map {|performer| performer.name}
    end

    def count_performers
      self.find_performers.length
    end

    def self.most_happening_location
      most_happening_location = Location.all[0]
      Location.all.each do |location_obj|
        if location_obj.count_events > most_happening_location.count_events 
          most_happening_location = location_obj
        end
      end
      p "#{most_happening_location.city}, #{most_happening_location.state} has #{most_happening_location.count_events} events"
    end

    def events_by_performer(performer)
      desired_performer_id = Performer.all.find_by(name: performer)
      desired_performers = self.events.select do |event|
        event.performer_id == desired_performer_id.id
      end
      desired_performers
    end

end