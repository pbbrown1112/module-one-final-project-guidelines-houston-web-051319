class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do | t |
      t.string :name
    end
  end
end
