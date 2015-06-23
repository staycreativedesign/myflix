Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home' => 'categories#index'
  resources :videos, only: [:index, :show]
  resources :categories, only: [:show]
end

