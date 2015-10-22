class GithubController < ApplicationController

  GITHUB_CONFIG = Rails.application.secrets.github_app

  def authorize
    address = github.authorize_url :redirect_uri => "http://#{request.host_with_port}/github/callback", :scope => 'repo'
    redirect_to address
  end

  def callback
    authorization_code = params[:code].to_s
    token = github.get_token(authorization_code)
    session[:github_token] = token.token
    redirect_to '/'
  end

  def github
    @github ||= Github.new client_id: GITHUB_CONFIG['client_id'],
                           client_secret: GITHUB_CONFIG['client_secret']
  end

  def logout
    session.delete(:github_token)
    redirect_to '/'
  end
end