Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "posts#index"

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update]

  get '/users/:id', :to => 'users#change_password'
  post '/users/:id', :to => 'users#update_password'

  resource :session, only: [:new, :create, :destroy]

end
