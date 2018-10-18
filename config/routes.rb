Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :wallpapers, :categories, :comments

  resources :wallpapers do
    resources :comments
    member do
      get 'fullsize'
    end
  end
  root 'categories#index'
  #get 'wallpaper/:id/fullsize', to: 'wallpapers#fullsize'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
