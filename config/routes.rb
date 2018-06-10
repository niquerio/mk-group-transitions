Rails.application.routes.draw do
  resources :polls, only: [:show]
  resources :tickets, only: [:show]
  
  resources :ballots, only: [:create]
  post '/ballots/build' => 'ballots#build', as: :build_ballot
  
  root to: "home#index" 
end
