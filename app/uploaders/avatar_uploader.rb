# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  # :nocov:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # :nocov:

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   #Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     "/images/fallback/" + ["avatar", version_name, "default.jpg"].compact.join('_')
   end

   version :micro do
     process :resize_to_fill => [50, 50]
     process :quality => 80
   end

   version :medium do
     process :resize_to_fill => [210, 210]
     process :quality => 80
   end

   version :large do
     process :resize_to_limit => [700, 700]
     process :quality => 80
   end

  # a white list of extensions which are allowed to be uploaded.
   def extension_white_list
     %w(jpg jpeg png)
   end
end
