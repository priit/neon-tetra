class Species < ActiveRecord::Base
  belongs_to :family
  
  validates_presence_of :common_name
end
