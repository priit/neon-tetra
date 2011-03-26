class CreateAquaria < ActiveRecord::Migration
  def self.up
    create_table :aquaria do |t|
      t.integer :user_id, :null => true
      t.integer :volume, :default => 30
      t.timestamps
    end
  end

  def self.down
    drop_table :aquaria
  end
end
