# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    case version_name
      when :small
        'http://baconmockup.com/266/200'
      when :thumb
        'http://placekitten.com/g/80/80'
      else
      'http://baconmockup.com/266/200'
    end
    #
    # will probably end up using this kind of fallback but I need to come
    # up with an image for it
    #"/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [80, 80]
  end

  version :small do
    process :resize_to_fill => [210, 210]
  end

  version :large do
    process :resize_to_limit => [600, 600]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end