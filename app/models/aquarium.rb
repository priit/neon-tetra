class Aquarium < ActiveRecord::Base
  belongs_to :user
  has_many :memberships  
  has_many :species, :through => :memberships do
    def << (*items)
      super( items - proxy_owner.species )
    end
  end
  
  validates_presence_of :volume
  validates_numericality_of :volume, :less_than => 3001, :greater_than => 0
  
  #TODO: is it needed
  after_save :clear_cache
  
  def add(sp, amount = nil)
    sp = Species.find_by_id(sp.to_i) unless sp.is_a?(Species)
    if sp && (amount = amount || sp.min_group_size).to_i > 0
      self.species << sp
      m = memberships.find_by_species_id(sp.id)
      m.update_attribute(:amount, m.amount + amount)
    end
    clear_cache
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
    clear_cache
  end
  
  def families
    @families ||= species.collect {|s| s.family}.uniq.sort_by {|f| f.common_name}
  end
  
  def max_size_difference
    sizes = species.collect {|s| s.size}.uniq
    (sizes.max - sizes.min).abs
  end
  
  def ph_range
    (species.collect {|s| s.min_ph}.compact.max .. species.collect {|s| s.max_ph}.compact.min)
  end
  
  def dh_range
    (species.collect {|s| s.min_dh}.compact.max .. species.collect {|s| s.max_dh}.compact.min)
  end
  
  def temperature_range
    (species.collect {|s| s.min_temperature}.compact.max .. species.collect {|s| s.max_temperature}.compact.min)
  end
  
  def specimen_count
    memberships.collect {|m| m.amount}.sum
  end
  
  def volume_needed
    memberships.collect {|m| m.volume}.sum
  end
  
  def effective_volume
    volume * 0.7
  end
  
  def used_volume_as_percent
    used = (volume_needed.to_f / effective_volume.to_f * 100).round
    case used
    when 0...30 then
      add_summary(:volume, 'good')
    when 30...65 then
      add_summary(:volume, 'pretty good')
    when 65...85
      add_summary(:volume, 'growded')
    else
      add_summary(:volume, 'oh my god')
      add_environment_error(:volume, "There is no room in your tank")
    end
    used
  end
  
  def summary
    @summary || {}
  end
  
  def environment_errors
    @environment_errors || {}
  end
  
  def species_list
    r = {}
    memberships.clone.each {|m| r[m.species.common_name] = m.amount }
    r
  end
  
  def family_list
    r = {}
    memberships.each do |m|
      r[m.family.common_name] ||= 0
      r[m.family.common_name] += m.amount
    end
    r
  end
  
  def status
    check_for_company
    check_for_compatability
    {
      'families' => family_list,
      'species' => species_list,
      'specimen_count' => specimen_count,
      'ranges' => {
        'temperature' => temperature_range.to_s,
        'ph' => ph_range.to_s,
        'dt' => dh_range.to_s
      },
      'volume' => {
        'total' => volume,
        'available' => effective_volume.round,
        'needed' => volume_needed,
        'used' => used_volume_as_percent
      },
      'summary' => summary,
      'errors' => environment_errors
    }
  end
  
  protected
  
  def clear_cache
    @summary, @environment_errors = nil, nil
  end
  
  private
  
  def check_for_company
    return if species.blank?
    lonely = []
    memberships.each do |m|
      lonely << m.species.common_name if m.lonely?
    end
    if !lonely.empty?
      add_summary(:company, "Some species may feel lonely!")
      add_environment_error(:company, "#{lonely.to_sentence} will die of boredom!")
    else
      add_summary(:company, 'ok')
    end
  end
  
  def check_for_compatability
    groups, result = {}, {}
    species.all(:select => [:size_descriptor, :common_name]).group_by {|s| s.size_descriptor}.each do |k, v|
      groups[k] = v.collect{|s| s.common_name}
    end
    
    #Group by size_descriptor
    groups.keys.sort.each do |index|
      agressors, victims = [], [] 
      
      groups.each do |k, v|
        if (index - k) > 1
          victims += v
        elsif (k - index) > 1
          agressors += v
        end
      end
      groups[index].each do |sp|
        result[sp] = {'agressors' => agressors, 'victims' => victims}
      end
    end
    
    groups = {}
    species.all(:select => [:agressivness, :common_name]).group_by {|s| s.size_descriptor}.each do |k, v|
      groups[k] = v.collect{|s| s.common_name}
    end
    add_environment_error(:compatbility, result)
    add_summary(:compatibility, 'fail!')
  end
  
  def add_summary(key, value)
    @summary ||= {}
    @summary[key.to_s] = value
  end
  
  def add_environment_error(key, value)
    @environment_errors ||= {}
    @environment_errors[key.to_s] = value
  end
end
