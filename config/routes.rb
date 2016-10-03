Rails.application.routes.draw do

  root 'home#index'

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  namespace :items do
    resources :bids, only: [:new, :create]
  end
end
