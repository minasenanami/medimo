Rails.application.routes.draw do
  root "home#index"
  resources :mypage, only: [:show]

  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :articles do
    resources :drafts, only: [:index, :show]
    resources :closes, only: [:index, :show]
  end

  resources :articles do
    resource :likes, only: [:create, :destroy]
    resource :keeps, only: [:create, :destroy]
  end
  resources :tags do
    get "articles", to: "articles#search"
  end
end
