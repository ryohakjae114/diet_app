require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DietApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # config.middleware.use ActionDispatch::Flash
    config.i18n.default_locale = :ja
    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true
    #　アプリケーションを日本時間に
    config.time_zone = 'Tokyo'
    #scaffoldをapiとして作成したい時に一時的に。
    #config.api_only = true
  end
end
