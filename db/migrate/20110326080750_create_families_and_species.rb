class CreateFamiliesAndSpecies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :common_name, :limit => 255, :null => false
      t.string :latin_name, :limit => 255
      t.integer :species_count
      t.timestamps
    end
    
    create_table :species do |t|
      t.string :common_name, :limit => 255, :null => false
      t.string :latin_name, :limit => 255
      t.integer :family_id, :references => :families, :null => false
    end
  end

  def self.down
    drop_table :species
    drop_table :families
  end
end
