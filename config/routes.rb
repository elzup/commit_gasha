Rails.application.routes.draw do

  # auth
  get '/github/auth' => 'github#authorize'
  get '/github/callback' => 'github#callback'
end
