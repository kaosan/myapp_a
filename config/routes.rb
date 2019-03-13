Rails.application.routes.draw do

  get 'sessions/new'
  get 'posts/search'

  resources :contacts
  root to: 'posts#top'
  resources :favorite_posts, only:[:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :posts do
    resources :comments
    collection do
      post :confirm
    end
  end
end
