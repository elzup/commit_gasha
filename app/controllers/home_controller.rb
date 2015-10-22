class HomeController < ApplicationController
  GITHUB_CONFIG = Rails.application.secrets.github_app
  def index
    @github =
    token = session[:github_token]
    if token

      response = RestClient.get("https://api.github.com/user?access_token=#{token}")
      user_info = JSON.parse(response)
      user = User.find_or_create_by(github_id: user_info['id'])
      # pp user_info

      github = Github.new :client_id => GITHUB_CONFIG['client_id'],
                          :client_secret => GITHUB_CONFIG['client_secret'],
                          :oauth_token => token
      pp user_info['login']
      # HACK: model化する
      pp events = JSON.parse(RestClient.get("https://api.github.com/users/#{user_info['login']}/events"))

    end
  end
end
