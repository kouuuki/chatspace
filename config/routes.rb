Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:edit, :update, :destroy]

  resources :groups, shallow: true do
    collection do
      get 'search'
    end
    resources :messages, :only => [:index, :new, :create, :destroy]
  end

  get '/users/search/:name', to: 'users#search'
  root 'groups#index'

  get '/api/callbacks', to: 'callbacks#callback'
  post '/api/callbacks', to: 'callbacsk#callback'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
