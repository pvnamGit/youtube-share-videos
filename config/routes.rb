Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'videos/index'

  root 'videos#index'

  resources :users, only: [:index, :create]

  resources :sessions, only: [:index, :create]

  delete '/logout', to: 'sessions#destroy'

end
