Rails.application.routes.draw do
  root 'posts#index'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get 'search'
      get 'admin'
      get 'archives'
    end
  end
end
