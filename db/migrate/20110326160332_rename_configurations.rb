class RenameConfigurations < ActiveRecord::Migration
  def self.up
    rename_table :configurations, :memberships
  end

  def self.down
    rename_table :memberships, :configurations
  end
end
