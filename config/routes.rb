Rails.application.routes.draw do

  # views
  root :to => 'home#index'

  get '/gasha' => 'gasha#index'
  get '/import' => 'home#import'

  # actions
  get '/gasha/turn' => 'gasha/turn'
  get '/gasha/turn10' => 'gasha/turn10'
  get '/gasha/res' => 'gasha/res'
  get '/gasha/res10' => 'gasha/res10'

  # auth
  get '/login' => 'github#authorize'
  get '/callback' => 'github#callback'
  get '/logout' => 'github#logout'
end
