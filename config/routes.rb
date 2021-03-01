Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'
  get '/about' => 'home#about'
  resources :users, only:[:index, :show, :edit, :update]
  resources :posts, only:[:index, :show, :create, :edit, :update, :new, :destroy] do
  	resources :comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
