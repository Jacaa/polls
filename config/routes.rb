Rails.application.routes.draw do

  root 'home#index'

  resources :polls, only: [:show, :create]
end
