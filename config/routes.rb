Rails.application.routes.draw do
  get 'profile/index'

  devise_for :users
  root 'posts#index'
  get 'posts#hashtags:/name', to:'posts#hashtags' 
  resources :posts, except:[:show] do
    post "/like", to: "likes#like_toggle"
    resources :comments, only: [:create, :destroy]
  end
  resources :follows, only: [:create, :destroy]
  resources :chips, only: [:destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
