Devise.setup do |config|
  OAUTH_CONFIG = YAML.load_file("#{Rails.root}/config/omniauth.yml")[Rails.env].symbolize_keys!

  # https://github.com/intridea/omniauth-github
  # http://developer.github.com/v3/oauth/
  # http://developer.github.com/v3/oauth/#scopes
  config.omniauth :github, OAUTH_CONFIG[:github]['key'], OAUTH_CONFIG[:github]['secret'], scope: 'user,public_repo'

  # https://github.com/arunagw/omniauth-twitter
  # https://dev.twitter.com/docs/api/1.1
  config.omniauth :twitter, OAUTH_CONFIG[:twitter]['key'], OAUTH_CONFIG[:twitter]['secret']
end
