class Species < ActiveRecord::Base
  belongs_to :family
  has_many :configurations
  has_many :aquaria, :through => :configurations
  
  acts_as_taggable_on :tags
  
  validates_presence_of :common_name

  has_attached_file :photo, :styles => {
    :medium => '300x300',
    :thumb  => '100x100'
  }
end
