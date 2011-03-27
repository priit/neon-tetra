class FixDefaultValues < ActiveRecord::Migration
  def self.up
    change_column :memberships, :amount, :integer, :default => 0
    change_column :aquaria, :volume, :integer, :default => 90
  end

  def self.down
  end
end
