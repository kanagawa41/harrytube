require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LensManage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.jbuilder false
      g.assets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end

    I18n.available_locales = %i(ja en)
    I18n.enforce_available_locales = true
    I18n.default_locale = :ja

    # 部分的にアプリケーションを読み込むことが可能になります。 ただし、これを行うとテンプレートはアプリケーションオブジェクト、またはメソッドを参照することが出来ません。
    config.assets.initialize_on_precompile = false

    # タイムゾーンの設定
    config.time_zone = 'Tokyo'

    # controller から lib配下を呼び込むためのおまじない
    # https://stackoverflow.com/questions/17007685/rails-4-uninitialized-constant-for-module
    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("lib")

    # field_with_errorsの出力を制御する
    # https://qiita.com/youcune/items/76a50ae3a2863a8f8b00
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
      else
        %Q(#{html_tag}).html_safe
      end
    end

  end
end
