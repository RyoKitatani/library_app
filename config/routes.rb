Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: 'homes#top'
  resources :user, only:[:index, :show, :edit, :update, :destroy] 
  resources :books, only:[:index, :show, :edit, :create, :update, :destroy] do
    resources :rentals, only:[:create, :destroy]
  end
  resources :categories, only:[:index, :new, :create, :edit, :update, :destroy]
  resources :rentals, only:[:index]
  post 'homes/guest_sign_in', to: 'homes#guest_sign_in'
end
