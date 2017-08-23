Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :courses
  devise_for :users
  
  root 'courses#index'

end
