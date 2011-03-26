class Species < ActiveRecord::Base
  belongs_to :family
  
  acts_as_taggable
  
  validates_presence_of :common_name
end
