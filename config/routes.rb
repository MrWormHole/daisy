Rails.application.routes.draw do
  root :to => 'public#index'

  devise_for :users
end
