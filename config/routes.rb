Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'
  get '/about' => 'home#about'
  resources :users, only:[:index, :show, :edit, :update]
  resources :posts, only:[:index, :show, :create, :edit, :update, :new, :destroy] do
  	resource :favorites, only:[:create, :destroy]
  	resource :comments, only:[:new, :creata, :destroy]
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
