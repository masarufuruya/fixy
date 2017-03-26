require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fixy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # 表示時のタイムゾーンをJSTに変更(Time.zone.nowも変わる)
    config.time_zone = 'Tokyo'
    # DB保存時のタイムゾーンをJSTに変更
    config.active_record.default_timezone = :local
  end
end
