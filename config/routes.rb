Rails.application.routes.draw do
  
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'wallpapers/index'
  get 'user/index'
  get 'home/index'
  devise_for :users
  get 'persons/profile', as: 'user_root'
  root 'home#index'
  resources :wallpapers
  root to: 'wallpapers#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
