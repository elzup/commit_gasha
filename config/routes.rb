Rails.application.routes.draw do

  root :to => 'home#index'

  get '/gasha' => 'gasha#index'
  get '/user' => 'user#index'

  # auth
  get '/github/auth' => 'github#authorize'
  get '/github/callback' => 'github#callback'
  get '/github/logout' => 'github#logout'
end
