class Aquarium < ActiveRecord::Base
  belongs_to :user
  has_many :memberships
  
  has_many :species, :through => :memberships do
    def << (*items)
      super( items - proxy_owner.species )
    end
  end
  
  def add(sp, amount = nil)
    sp = Species.find_by_id(sp.to_i) unless sp.is_a?(Species)
    if sp && (amount = amount || sp.min_group_size).to_i > 0
      self.species << sp
      m = memberships.find_by_species_id(sp.id)
      m.update_attribute(:amount, m.amount + amount)
    end
  end
  
  def remove(sp, amount = nil)
    sp = Species.find_by_id(sp.to_i) unless sp.is_a?(Species)
    amount = amount.to_i
    
    if sp && (m = memberships.find_by_species_id(sp.id))
      if amount.to_i < 1 || (m.amount - amount) < 1
        m.destroy
      else
        m.update_attribute(:amount, m.amount - amount)
      end
    end
  end
  
  def families
    @families ||= species.collect {|s| s.family}.uniq.sort
  end
  
  def max_size_difference
    sizes = species.collect {|s| s.size}.uniq
    (sizes.max - sizes.min).abs
  end
  
  def ph_range
    (species.collect {|s| s.min_ph}.max .. species.collect {|s| s.max_ph}.min)
  end
  
  def dt_range
    (species.collect {|s| s.min_dt}.max .. species.collect {|s| s.max_dt}.min)
  end
end
