Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :users do
    resources :articles, except: :index
  end

  resources :articles, only: :index


  resources :comments, only: :create

  resources :articles do
    resources :comments
  end

  root 'articles#index'
end
