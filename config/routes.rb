Rails.application.routes.draw do
  devise_for :users, coontrollers: { sessions: 'users/sessions'}
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
  # Defines the root path route ("/")
end
