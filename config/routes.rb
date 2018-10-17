Rails.application.routes.draw do
  devise_for :users
  resources :wallpapers, :categories, :posts
  
  resources :wallpapers do
    resources :posts
  end

  root 'categories#index'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'wallpapers/:id/fullsize', to: 'wallpapers#fullsize', as: 'fullsize', method: 'show'
end
