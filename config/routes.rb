Rails.application.routes.draw do
  resources :polls, only: [:show]
  resources :tickets, only: [:show]
  root to: "home#index" 
end
