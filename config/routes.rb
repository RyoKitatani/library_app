Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books, only:[:index, :show, :edit, :create, :update, :destroy] do
    resources :rentals, only:[:create, :destroy]
  end
  resources :categories, only:[:index, :new, :create, :edit, :update, :destroy]
end
