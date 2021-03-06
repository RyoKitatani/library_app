Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :users, only:[:index, :show, :edit, :update, :destroy]
  resources :books, only:[:index, :new, :show, :edit, :create, :update, :destroy] do
    resources :rentals, only:[:create, :destroy]
    resources :bookmarks, only:[:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :categories, only:[:index, :new, :show, :create, :edit, :update, :destroy]
  resources :rentals, only:[:index]
  post 'homes/guest_sign_in', to: 'homes#guest_sign_in'
  post 'homes/admin_sign_in', to: 'homes#admin_sign_in'
  get '/booksearch', to: 'books#new'
end
