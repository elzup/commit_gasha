Rails.application.routes.draw do

  root :to => 'home#index'

  get '/gasha' => 'gasha#index'
  get '/import' => 'home#import'

  # auth
  get '/login' => 'github#authorize'
  get '/callback' => 'github#callback'
  get '/logout' => 'github#logout'
end
