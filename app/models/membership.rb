class Membership < ActiveRecord::Base
  belongs_to :species
  belongs_to :aquarium
  
  def volume
    species.volume * amount
  end
end
