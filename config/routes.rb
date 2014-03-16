ShinsonLearning::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: "registrations" }

  resources :users, only: [:show]
  resources :techniques do
    resources :notes, only: [:create, :edit, :update, :destroy, :index]
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

  root to: "home#index"
end
