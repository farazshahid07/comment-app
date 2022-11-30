Rails.application.routes.draw do

  root 'users#index'

  concern :commentable do
    resources :comments, only: [:new, :create, :destroy]
  end

  resources :users do  
    resources :posts, concerns: :commentable
  end

  resources :users do  
    resources :articles, concerns: :commentable
  end

  resources :comments, concerns: :commentable

end
