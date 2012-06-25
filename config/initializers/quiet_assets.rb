# Bit of a hack to get rid of the following lines from log files
# Started GET "/assets/pictures.js?body=1" for 127.0.0.1 at 2012-06-24 17:08:42 -0700
Rails::Rack::Logger.class_eval do
  if Rails.env.development?
    def call_with_quiet_assets(env)
      previous_level = Rails.logger.level
      Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0
      call_without_quiet_assets(env).tap do
        Rails.logger.level = previous_level
      end
    end
    alias_method_chain :call, :quiet_assets
  end
end
