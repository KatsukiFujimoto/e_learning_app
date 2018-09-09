Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: [:destroy, :new, :create] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show] do 
    resources :words, only: [:index]
  end
  resources :lessons
  namespace :admin do
    resources :users, only: [:index, :destroy, :update]
    resources :categories do 
        resources :words
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
