Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
  root 'posts#index'
end
