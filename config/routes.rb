Rails.application.routes.draw do

  root 'welcome#home'

  get '/auth/facebook/callback' => 'sessions#create'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :directors do
    resources :movies
  end
  resources :format


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
