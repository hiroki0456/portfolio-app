Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :questions, only: [:new, :create] do
    collection do
      get 'confirm'
    end
  end
end
