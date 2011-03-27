class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.integer :aquarium_id, :null => false
      t.integer :species_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end

end
