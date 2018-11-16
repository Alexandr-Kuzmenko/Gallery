Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    devise_for :admin_users, :categories, :wallpapers, :comments, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :users
    resources :users, :comments, :activities

    resources :wallpapers do
      resources :comments
      resources :likes, only: [:new, :create, :destroy]
    end

    resources :categories do
      resources :subscriptions, only: [:new, :create, :destroy]
    end

    get ':/locale', to: 'categories#index'
    get 'user/index', to: 'users#index'
    get 'wallpaper/:id/fullsize', to: 'wallpapers#fullsize', as: 'fullsize', method: 'show'

    match 'admin/parsing', to: 'admin/parsing#index', via: [:get, :post]

    root 'categories#index'

    # resources :users do
    #   member do
    #     get 'user/index', to: 'users#index'
    #   end
    # end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end