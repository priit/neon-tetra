class AddTagsToSpecies < ActiveRecord::Migration
  def self.up
    add_column :species, :tags, :string
  end

  def self.down
    remove_column :species, :tags
  end
end
