Rails.application.routes.draw do
  resources :polls, only: [:show]
  resources :tickets, only: [:show]
  
  resources :ballots, only: [:create]
  post '/ballots/new' => 'ballots#new', as: :new_ballot
  
  root to: "home#index" 
end
