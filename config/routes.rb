Rails.application.routes.draw do

  resource :cart, only: [:show] do
    get :purchase
  end

  resources :order_items, only: [:create, :update, :destroy]

  mount Ckeditor::Engine => '/ckeditor'
  
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

  resources :answers

  resources :eval_results #add constraints, don't need all routes

  resources :forum_threads do
    resources :forum_posts, module: :forum_threads
  end


  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, :only => [:show]

  root 'courses#index'
  
  get '/masquerade' => "pages#masquerade"

end
