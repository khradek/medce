Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  mount Ckeditor::Engine => '/ckeditor'

  resources :med_profs, :path => "medical_professionals"
  
  resources :email_subscribers
  
  resources :blogs
  
  resources :articles
  
  resources :answers
  
  resources :eval_results #add constraints, don't need all routes
  
  resources :order_items, only: [:create, :update, :destroy]

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, :only => [:show] #must be below devise_for line

  resource :subscription 

  resource :card
  
  resource :cart, only: [:show] do
    get :purchase
  end

  resources :courses do
    get :preview
    get :take_evaluation
    post :grading
    get :results
  end

  resources :evaluations do
    resources :questions, controller: 'evaluations/questions' do
      collection do
        patch :sort
      end
    end
  end

  resources :forum_threads do
    resources :forum_posts, module: :forum_threads
  end

  root 'pages#home'
  
  get '/masquerade' => "pages#masquerade"
  get '/about' => "pages#about"
  get '/home' => "pages#home"
  get '/videos' => "pages#videos"
  get '/contact' => "pages#contact"

end
