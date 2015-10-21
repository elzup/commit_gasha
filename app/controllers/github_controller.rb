class GithubController < ApplicationController

  GITHUB_CONFIG = Rails.application.secrets.github_app
  def authorize
    pp GITHUB_CONFIG['client_secret']
    pp GITHUB_CONFIG['client_id']
    @github = Github.new :client_id => GITHUB_CONFIG['client_id'], :client_secret => GITHUB_CONFIG['client_secret']
    address = @github.authorize_url :redirect_uri => "http://#{request.host_with_port}/github/callback", :scope => 'repo'
    redirect_to address
  end

  def callback
    authorization_code = params[:code].to_s

    @github = Github.new :client_id => GITHUB_CONFIG['client_id'], :client_secret => GITHUB_CONFIG['client_secret']
    token = @github.get_token(authorization_code)

    access_token = token.token

    # EX: https://api.github.com/user/repos?access_token=xxxxx

    response =  RestClient.get("https://api.github.com/user/repos?access_token=#{access_token}")
    datas = JSON.parse(response)
    pp datas

    puts "datas : #{datas}" # It will print the whole github response details as a json

    redirect_to '/' # any path that you want to redirect the user after importing
  end
end