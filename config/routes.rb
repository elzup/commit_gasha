Rails.application.routes.draw do
  devise_for :user, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    sessions: "sessions"
  }
end
