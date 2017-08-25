Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  
  resources :courses

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, :only => [:show]

  root 'courses#index'

end
