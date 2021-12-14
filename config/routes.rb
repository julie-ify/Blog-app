Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  resources :users, only: %i[index show] do 
    resources :posts, only: %i[index new create show]
  end

  resources :posts do
    resources :comments, only: %i[create]
    resources :likes, only: %i[create]
  end
end
