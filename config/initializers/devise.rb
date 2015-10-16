Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  OAUTH_CONFIG = YAML.load_file("#{Rails.root}/config/omniauth.yml")[Rails.env].symbolize_keys!

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # https://github.com/intridea/omniauth-github
  # http://developer.github.com/v3/oauth/
  # http://developer.github.com/v3/oauth/#scopes
  config.omniauth :github, OAUTH_CONFIG[:github]['key'], OAUTH_CONFIG[:github]['secret'], scope: 'user,public_repo'

  # https://github.com/arunagw/omniauth-twitter
  # https://dev.twitter.com/docs/api/1.1
  config.omniauth :twitter, OAUTH_CONFIG[:twitter]['key'], OAUTH_CONFIG[:twitter]['secret']
end
