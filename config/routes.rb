Rails.application.routes.draw do
   
  get 'signup' => 'users#new'
  root 'pages#home'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'help' => 'pages#help'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
