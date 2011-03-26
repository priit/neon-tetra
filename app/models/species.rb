class Species < ActiveRecord::Base
  belongs_to :family
  has_many :memberships
  has_many :aquaria, :through => :memberships
  
  acts_as_taggable_on :tags
  
  validates_presence_of :common_name, :family_id

  has_attached_file :photo, :styles => {
    :thumb  => '150x113#',
    :small  => '350x263#',
    :medium => '410x308#',
    :huge   => '870x653#'
  }
  
  def volume
    #e.g 3 cm => 30l
    size.floor * 10
  end

  def photo_thumb
    photo.url(:thumb) if photo?
  end

  def photo_small
    photo.url(:small) if photo?
  end

  def photo_medium
    photo.url(:medium) if photo?
  end

  def photo_huge
    photo.url(:huge) if photo?
  end



end
