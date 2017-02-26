Rails.application.routes.draw do

  resources :categories

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end


end
