class Membership < ActiveRecord::Base
  belongs_to :species
  belongs_to :aquarium
  
  delegate :family, :to => :species
  
  def volume
    species.volume * amount
  end
  
  def lonely?
     amount < species.min_group_size
  end
end
