class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do | t |
      t.string :name
      t.string :date
      t.string :time
      t.integer :performer_id
      t.integer :location_id
      t.string :venue_url
      t.string :performer_tickets
    end
  end
end
