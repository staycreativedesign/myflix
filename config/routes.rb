Myflix::Application.routes.draw do
  root to: "static#main"
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'categories#index'
  get 'my_queue', to: 'queue_items#index'
  
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  
  resources :users, only: [:new, :create] do
  end
  resources :videos, only: [:index, :show] do
    resources :reviews
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  get 'ui(/:action)', controller: 'ui'
end

