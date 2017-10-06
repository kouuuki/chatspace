Rails.application.routes.draw do
  
  resources :groups, shallow: true do
    collection do
      get 'search'
    end
    resources :messages
  end

  devise_for :users
  resources :users
  root 'groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
