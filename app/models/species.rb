class Species < ActiveRecord::Base
  belongs_to :family
  
  has_many :configurations
  has_many :aquaria, :through => :configurations
  
  acts_as_taggable
  
  validates_presence_of :common_name
end
