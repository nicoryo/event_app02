Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  devise_for :users
  # root 'comments#index'
  # get 'comments/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, :only => [:index, :show]
  root "users#index"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :relationships, only: [:create, :destroy]
end
