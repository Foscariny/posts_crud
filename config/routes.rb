Rails.application.routes.draw do
  
  root "posts#index"
  get "/posts", to: "posts#index"
  delete "/posts/:id", to: "posts#destroy"
  get "/posts/new", to: "posts#new"
  get "/posts/edit/:id", to: "posts#edit", as: "post_edit"
  post "/posts", to: "posts#create"
  get "/posts/:id", to: "posts#show", as: "post"
  patch "/posts/:id", to: "posts#update"
  put "/posts/:id", to: "posts#update"
 end