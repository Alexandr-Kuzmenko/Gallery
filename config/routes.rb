Rails.application.routes.draw do
  devise_for :admin_users, :categories, :wallpapers, :comments, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :users, :categories, :comments
  resources :wallpapers do
    resources :comments, :likes
    #member do
    #end
  end
  get 'user/index', to: 'users#index'
  get 'wallpaper/:id/fullsize', to: 'wallpapers#fullsize', as: 'fullsize', method: 'show'
  #resources :users do
  #  member do
  #    get 'user/index', to: 'users#index'
  #  end
  #end
  root 'categories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
