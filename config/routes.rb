Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#dashboard'
  get '/learned-categories', to: 'users#category'
  get '/learned-words', to: 'users#word'
  resources :users, except: [:destroy, :new, :create] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
  resources :lessons, only: [:create, :show] do 
    resources :words, only: [:new, :create]
  end 
  namespace :admin do
    resources :users, only: [:index, :destroy, :update]
    resources :categories do 
        resources :words
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
