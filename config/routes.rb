ShinsonLearning::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes self

  devise_for :users, controllers: { registrations: "registrations" }

  resources :users, only: [:show]
  resources :techniques do
    get :multiple_new, to: "techniques#new_multiple", on: :collection
    post :multiple_create, to: "techniques#create_multiple", on: :collection

    resources :notes, only: [:new, :create, :edit, :update, :destroy, :index]
  end
  resources :questions, only: [:index]

  resources :studies, only: [:new, :create, :show,
                             :index, :destroy, :edit, :update] do
    member do
      get :study
    end

    resources :scores, only: [:create, :index]
  end

  resources :searches, only: [:create]

  resources :logs, only: [:create]

  get '/exports/new', to: "exports#new", as: 'new_export'
  post '/exports/show', to: "exports#show", as: 'export'

  root to: "home#index"
end
