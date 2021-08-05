Rails.application.routes.draw do
  root "articles#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :articles do
    resource :likes, only: [:create, :destroy]
    resource :keeps, only: [:create, :destroy]
  end
  resources :tags do
    get "articles", to: "articles#search"
  end
end
