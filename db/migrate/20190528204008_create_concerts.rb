class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do | t |
      t.string :name
      t.integer :artist_id
      t.integer :location_id
    end
  end
end
