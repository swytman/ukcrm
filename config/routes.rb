Rails.application.routes.draw do
  root :to => 'static_pages#index'

  resources :counters do
    member do
      get :tariffs
    end
  end


  resources :meterings
  resources :tariffs

end
