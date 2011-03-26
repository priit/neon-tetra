class FixMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :amount, :integer, :default => 1
  end

  def self.down
    remove_column :membershipds, :amount
  end
end
