Rails.application.routes.draw do
  #get 'persons/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :wallpapers, :categories#, :users
  root 'wallpapers#index'

  
  devise_for :users
  resources :wallpapers, :categories
  #get 'persons/profile', as: 'user_root'
  root 'wallpapers#index'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
