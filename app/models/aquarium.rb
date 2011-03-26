class Aquarium < ActiveRecord::Base
  has_many :configurations
  has_many :species, :through => :configurations
  
  def families
    @families ||= species.collect {|s| s.family}.uniq.sort
  end
end
