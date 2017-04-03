# Be sure to restart your server when you modify this file.
# Cookieに設定している場合はexpire_after設定しないとブラウザ終了すると消える
Rails.application.config.session_store :cookie_store, key: '_fixy_session', expire_after: 1.month
