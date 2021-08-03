Rails.application.routes.draw do
  root "articles#index"
  devise_for :users
  resources :articles do
    resource :likes, only: [:create, :destroy]
  end
end
