Rails.application.routes.draw do
  get '/'=> 'posts#index'

  get '/show'=> 'posts#show'
end
