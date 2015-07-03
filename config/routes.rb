Myflix::Application.routes.draw do
  root to: "static#main"
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  resources :users, only: [:new, :create]
  resources :videos, only: [:index, :show] do
  	collection do
  		get 'search', to: 'videos#search'
  	end
  end
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  get 'ui(/:action)', controller: 'ui'
end

