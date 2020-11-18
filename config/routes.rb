Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :questions, only: [:new, :create]
end
