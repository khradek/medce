Rails.application.routes.draw do

  resource :cart, only: [:show] do
    get :purchase
  end
  
  resources :order_items, only: [:create, :update, :destroy]

  mount Ckeditor::Engine => '/ckeditor'
  
  resources :courses

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, :only => [:show]

  root 'courses#index'

end
