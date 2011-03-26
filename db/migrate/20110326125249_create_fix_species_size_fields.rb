class CreateFixSpeciesSizeFields < ActiveRecord::Migration
  def self.up
    change_column :species, :size, :decimal, :precision => 8, :scale => 2
  end

  def self.down
  end
end
