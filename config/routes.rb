Rails.application.routes.draw do

  devise_for :users, :controllers => {:confirmations => "confirmations"}

  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  root :to => 'static_pages#index'

  resources :counters do
    member do
      get :tariffs
    end
  end


  resources :meterings
  resources :tariffs

  resources :groups
  resources :roles
  resources :users
  resources :villages do
    member do
      get :users
      get :counters
    end
  end


end
