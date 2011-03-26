class Aquarium < ActiveRecord::Base
  belongs_to :user
  has_many :memberships
  has_many :species, :through => :memberships
  
  def add(species, amount = nil)
  end
  
  def remove(species, amount = nil)
  end
  
  def families
    @families ||= species.collect {|s| s.family}.uniq.sort
  end
  
  def max_size_difference
    sizes = species.collect {|s| s.size}.uniq
    (sizes.max - sizes.min).abs
  end
  
  def ph_range
    (species.collect {|s| s.min_ph}.max ... species.collect {|s| s.max_ph}.min)
  end
  
  def dt_range
    (species.collect {|s| s.min_dt}.max ... species.collect {|s| s.max_dt}.min)
  end
end
