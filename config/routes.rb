Rails.application.routes.draw do
  devise_for :users
  root :to => 'static_pages#index'

  resources :counters do
    member do
      get :tariffs
    end
  end


  resources :meterings
  resources :tariffs

  resources :groups
  resources :users
  resources :villages do
    member do
      get :users
    end
  end


end
