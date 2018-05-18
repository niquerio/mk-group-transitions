Rails.application.routes.draw do
  resources :polls, only: [:show]
  root to: "home#index" 
end
