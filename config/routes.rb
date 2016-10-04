Rails.application.routes.draw do

  root 'home#index'

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # resources :items, only: [:new, :create, :index, :show]

  post '/items/:id/publish' => 'items#publish', as: :publish

  resources :items, only: [:new, :create, :index, :show] do
    resources :bids, only: [:new, :create]
  end
end
