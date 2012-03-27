module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
end

CarrierWave.configure do |config|
  # keys are stored as heroku config vars
  # see https://aws-portal.amazon.com/gp/aws/securityCredentials for credentials
  # s3 management console:
  # https://console.aws.amazon.com/s3/home?#
  # http://devcenter.heroku.com/articles/config-vars
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET'],
    :region                 => 'us-east-1'
  }
  # fog_directory == the name of the bucket
  config.fog_directory  = ENV['S3_BUCKET']
end

if Rails.env.test?
  CarrierWave.configure do |config|
    # speed up the tests
    config.enable_processing = false
  end
end
