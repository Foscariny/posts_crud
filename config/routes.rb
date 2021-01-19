Rails.application.routes.draw do
  
  root "posts#index"

  # Rotas dos Posts
  get "/posts", to: "posts#index"
  get "/posts/filter/:filter", to: "posts#filter", as: "posts_filter"
  get "/posts/search", to: "posts#search", as: "posts_search"
  delete "/posts/:id", to: "posts#destroy"
  get "/posts/new", to: "posts#new"
  get "/posts/edit/:id", to: "posts#edit", as: "post_edit"
  post "/posts", to: "posts#create"
  get "/posts/:id", to: "posts#show", as: "post"
  patch "/posts/:id", to: "posts#update"
  put "/posts/:id", to: "posts#update"

  # Rotas dos Usuários
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]
  get "users/:id/send-email", to: "users#email", as: "email"
  # Rotas das sessions
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

 end