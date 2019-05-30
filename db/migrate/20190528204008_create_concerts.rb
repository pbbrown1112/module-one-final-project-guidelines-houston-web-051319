class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do | t |
      t.string :name
      t.string :date
      t.string :time
      t.integer :artist_id
      t.integer :location_id
      t.string :venue_url
      t.string :artist_tickets_url
    end
  end
end
