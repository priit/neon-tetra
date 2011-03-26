class Species < ActiveRecord::Base
  belongs_to :family
  has_many :configurations
  has_many :aquaria, :through => :configurations
  
  acts_as_taggable_on :tags
  
  validates_presence_of :common_name, :family_id

  has_attached_file :photo, :styles => {
    :thumb  => '150x113#',
    :small  => '350x263#',
    :medium => '410x308#',
    :huge   => '870x653#'
  }
end
