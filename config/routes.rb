ShinsonLearning::Application.routes.draw do
  devise_for :users

  resources :techniques do
    resources :notes, only: [:create, :edit, :update, :destroy]
  end

  resources :questions, only: [:index]

  root to: "home#index"
end
