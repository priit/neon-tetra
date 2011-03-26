class Configuration < ActiveRecord::Base
  belongs_to :species
  belongs_to :aquarium
end
