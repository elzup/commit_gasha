Rails.application.routes.draw do

  root :to => 'home#index'

  # auth
  get '/github/auth' => 'github#authorize'
  get '/github/callback' => 'github#callback'
end
