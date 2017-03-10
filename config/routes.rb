Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'posts#index'

  resources :categories

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :likes, only: [:index]
    get   :edit_password, on: :member
    patch :update_password, on: :member
  end

  resources :sessions, only: [:new, :create,] do
    delete :destroy, on: :collection
  end



end
