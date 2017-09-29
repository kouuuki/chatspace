Rails.application.routes.draw do
  resources :messages
  devise_for :users
  resources :users
  resources :groups
  root 'messages#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
