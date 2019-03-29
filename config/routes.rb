Rails.application.routes.draw do

  get 'sessions/new'
  get 'posts/search'

  resources :users, only: [:index]
  resources :relationships, only: [:create, :destroy]

  resources :contacts
  root to: 'posts#top'
  resources :favorite_posts, only:[:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments
    collection do
      post :confirm
    end
  end
  resources :conversations do
    resources :messages
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

end
