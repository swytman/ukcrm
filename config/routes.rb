Rails.application.routes.draw do

  devise_for :users, :controllers => {:confirmations => "confirmations"}

  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  root :to => 'static_pages#index'

  resources :groups
  resources :roles
  resources :users do
    member do
      get :remind_to_send_counters
      patch :send_counters
    end
  end

  resources :reports do
    collection do
      get :monthly_counters
    end
  end

  resources :villages do
    member do
      get :users
    end
    resources :properties do
      resources :meterings
    end
    resources :counters do
      resources :tariffs
    end
  end


end
