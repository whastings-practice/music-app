MusicApp::Application.routes.draw do

  root to: 'bands#index'

  resources :users, only: [:new, :create]

  resource :session, only:[:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:index, :new, :create]
  end

  resources :albums, only: [:show, :edit, :update, :destroy]

end
