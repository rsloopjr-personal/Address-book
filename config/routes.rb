Rails.application.routes.draw do
  resources :share_invites do
    member do
      get :accept
      get :decline
    end
  end
  resources :homes
  resources :contact_groups do
    member do
      get :share_new #, to: 'contact_groups#share_new', as: :share_new
      patch :share_create #, to: 'contact_groups#share_create', as: :share_create
    end
  end
  resources :contacts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'
end
