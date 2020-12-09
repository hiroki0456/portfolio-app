Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :questions, only: [:new, :create, :show] do
    collection do
      get 'confirm'
    end
    resources :comments, only: [:create, :edit] do
      member do
        get 'like'
      end
      collection do
        get 'find_like'
      end
    end
  end
end
