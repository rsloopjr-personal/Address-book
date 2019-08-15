Rails.application.routes.draw do
  resources :homes, :only => [:index]
  resources :contact_groups do
    resources :share_invites, shallow: true, :only => [:new, :create, :destroy] do
      member do
        get :accept
        get :decline
      end
    end
  end
  resources :contacts
  devise_for :users
  resources :share_invites, :only => [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'
end
