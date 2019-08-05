Rails.application.routes.draw do
  root :to => 'public#home'
  devise_for :users
  resources :posts do
    member do
      get :delete
    end
  end
end
