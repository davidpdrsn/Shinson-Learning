ShinsonLearning::Application.routes.draw do
  devise_for :users

  resources :techniques

  root to: "home#index"
end
