Rails.application.routes.draw do
   
  get 'sessions/new'
  resources :users
  resources :sessions, :only =>[:new, :create, :destroy]
  root 'pages#home'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'help' => 'pages#help'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  get 'signout' => 'sessions#destroy'
  delete 'signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
