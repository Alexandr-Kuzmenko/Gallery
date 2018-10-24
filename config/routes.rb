Rails.application.routes.draw do
  get 'home/index'
  devise_for :admin_users, :wallpapers, :categories, :comments, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :wallpapers, :categories, :comments

  resources :wallpapers do
    resources :comments
    member do
      get 'wallpaper/:id/fullsize', to: 'wallpapers#fullsize', as: 'fullsize', method: 'show'
    end
  end
  root 'categories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
