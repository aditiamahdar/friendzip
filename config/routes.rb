Rails.application.routes.draw do
  resources :updates, only: :create
  resources :blocks, only: :create do
    collection { delete '/', action: :destroy }
  end
  resources :subscribes, only: :create do
    collection { delete '/', action: :destroy }
  end
  resources :friends, except: [:update, :destroy] do
    collection { delete '/', action: :destroy }
  end
end
