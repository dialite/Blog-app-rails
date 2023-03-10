Rails.application.routes.draw do
  devise_for :users
  get 'likes/create'
  get 'comments/new'
  get 'comments/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope  :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for controllers: { registrations: 'registrations' }

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
