Rails.application.routes.draw do
  root 'home#index'

  resources :home
  get 'home/index'
end
