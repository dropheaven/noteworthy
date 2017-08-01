Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :articles, except: :index
  end

  resources :articles, only: :index

  root 'articles#index'
end
