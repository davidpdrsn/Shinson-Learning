ShinsonLearning::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :techniques do
    resources :notes, only: [:create, :edit, :update, :destroy]
  end
  resources :questions, only: [:index]

  resources :studies, only: [:new, :create, :show, :index]

  root to: "home#index"
end
