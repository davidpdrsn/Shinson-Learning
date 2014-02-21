ShinsonLearning::Application.routes.draw do
  devise_for :users

  resources :techniques do
    resources :notes
  end

  root to: "home#index"
end
