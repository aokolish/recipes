class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  attr_accessible :image, :caption, :image_cache

  validates :image, :presence => true
  mount_uploader :image, ImageUploader

  default_scope order("position")
  scope :top_five, limit(5)

  acts_as_list

end

