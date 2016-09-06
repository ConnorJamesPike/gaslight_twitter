Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  root 'sessions#new'

  resources :users do
	member do
		get :following, :followers, :favorite_tweets
	end
  end
  resources :tweets, only: [:create, :destroy] do
	member do
		get :favoriters
	end
  end
  resources :follows, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
