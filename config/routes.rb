Rails.application.routes.draw do
  get 'categories/new'
  get 'categories/edit'
  get 'rentals/create'
  get 'rentals/destroy'
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  get 'books/new'
  devise_for :users
  root to: 'homes#top'
end
