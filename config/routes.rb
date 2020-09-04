Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users,    only: [:new, :create, :show, :edit, :update]
  root "feeds#index"
  resources :feeds do
    collection do
      post :confirm
    end
  end
end
