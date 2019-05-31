class Event < ActiveRecord::Base
    belongs_to :performer
    belongs_to :location

end
