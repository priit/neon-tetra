class AddExtraFieldsForSpecies < ActiveRecord::Migration
  def self.up
    add_column :species, :tank_size, :integer, :limit => 1
    add_column :species, :size, :decimal, :precision => 8, :scale => 2
    add_column :species, :size_descriptor, :integer, :limit => 1
    add_column :species, :agressivness, :integer, :limit => 1
    add_column :species, :activity, :integer, :limit => 1
    add_column :species, :shield, :integer, :limit => 1
    add_column :species, :endurance, :integer, :limit => 1
    add_column :species, :plant_eater, :boolean
    add_column :species, :min_group_size, :integer, :limit => 2
    add_column :species, :min_temperature, :integer, :limit => 2
    add_column :species, :max_temperature, :integer, :limit => 2
    add_column :species, :min_ph, :float, :limit => 2
    add_column :species, :max_ph, :float, :limit => 2
    add_column :species, :min_dh, :integer, :limit => 3
    add_column :species, :max_dh, :integer, :limit => 3
    add_column :species, :description, :text
  end

  def self.down
    remove_column :species, :tank_size
    remove_column :species, :size
    remove_column :species, :size_descriptor
    remove_column :species, :agressivness
    remove_column :species, :activity
    remove_column :species, :shield
    remove_column :species, :endurance
    remove_column :species, :plant_eater
    remove_column :species, :min_group_size
    remove_column :species, :min_temperature
    remove_column :species, :max_temperature
    remove_column :species, :min_ph
    remove_column :species, :max_ph
    remove_column :species, :min_dh
    remove_column :species, :max_dh
    remove_column :species, :description
  end
end
