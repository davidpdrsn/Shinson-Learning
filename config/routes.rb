ShinsonLearning::Application.routes.draw do
  devise_for :users

  resources :techniques do
    resources :notes, only: [:create, :edit, :update, :destroy]
  end

  root to: "home#index"
end
