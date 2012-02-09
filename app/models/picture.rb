class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  attr_accessible :image, :caption

  validates :image, :presence => true
  mount_uploader :image, ImageUploader

end

