Rails.application.routes.draw do
#ネストテスト
  resources :groups, shallow: true do
    collection do
      get 'search'
    end
    resources :messages
  end

  #resources :messages
  devise_for :users
  resources :users
  #resources :groups
  root 'groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
