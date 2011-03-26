class Membership < ActiveRecord::Base
  belongs_to :species
  belongs_to :aquarium
end
