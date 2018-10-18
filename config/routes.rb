Rails.application.routes.draw do
  devise_for :users
  resources :wallpapers, :categories, :posts
  
  resources :wallpapers do
    resources :posts
  end
  get 'wallpapers/:id/fullsize', to: 'wallpapers#fullsize', as: 'fullsize', method: 'show'
  root 'categories#index'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
