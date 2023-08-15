require 'sidekiq/web'

Rails.application.routes.draw do

  get 'notifications/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'video_shares/index'

  root 'video_shares#index'

  resources :users, only: [:index, :create]

  resources :sessions, only: [:index, :create]

  delete '/logout', to: 'sessions#destroy'

  resources :video_shares

  post '/create_share_video', to: 'video_shares#create'

  get '/my_videos', to: 'video_shares#my_videos'


  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

end
