Rails.application.routes.draw do
  get 'comments/create'

  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :comments
  end
end
